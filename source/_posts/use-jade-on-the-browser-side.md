title: 在浏览器端使用jade
date: 2016-01-03 15:30:26
tags:
- jade
- pug
- browser

---

Jade 是一个高性能的模板引擎，它深受 [Haml](http://haml-lang.com) 影响，它是用 JavaScript 实现的, 并且可以供 [Node](http://nodejs.org) 使用.

> 由于版权原因，jade更名为pug，详见[issue](https://github.com/pugjs/jade/issues/2184)

本文不介绍如何在node端使用jade,具体使用方法可见官方文档或express文档。

在某些情况下，我们并不需要总是在后端去渲染模板。比如当我们编写一篇文章而又没有写完时，我们仅仅是想看一下预览效果，不希望去请求服务端保存，这时就要求预览的模板与样式与我们后端的一样，这种情况下就用到了在浏览器端进行渲染。

<!-- more -->

## 准备工作

为了保持结构和效果的统一，我们需要用到和后端一样的模板文件。最直接的方法就是使用线上的`filename.jade`模板。而一般情况下，在浏览器端，我们是访问不到我们编写的这些模板文件的。

有两种方法去解决此问题：
* 将我们需要用到的模板文件拷贝到`public`文件夹内（假设浏览器端可以访问此目录）。
* 将模板文件编译成一个js文件，然后在浏览器端调用渲染html

## 前端渲染jade模板文件

最新版本的jade和最新版本的浏览器才支持此特性。并且一个独立的运行环境特别大(v1.11.0大小为260K+)。官方不建议使用此种方法，本文也不赘述，详见官方文档。

## 预编译jade模板文件

官方建议将jade模板文件进行预编译，然后在浏览器端仅仅使用`runtime.js`，此版本大小为7k。

首先我们需要全局安装`jade`

```
npm install -g jade
```

使用如下命令编译需要编译的模板文件(filename.jade)

```
jade --client --no-debug filename.jade
```

然后会生成一个`filename.js`的文件，包含了编译后的模板。

此时，我们在前端可以引入`runtime.js`,`filename.js`,然后通过js调用`filename.js`中函数，并传入参数(如果需要)，将会渲染出我们需要的html代码。

## 进阶·自动预编译jade模板

以上方法都是手工编译，当我们原始模板改变之后，需要手工运行命令进行编译。这样极不方便，并且线上环境也不允许这样操作。

将预编译写成一工具类(`app/utils/jade-util.js`)

```
var jade = require('jade');
var fs = require('fs');
var path = require("path");
var _cwd = process.cwd();
var _ = require('lodash');

var sourcePath = _cwd + '/views/pages';
var targetPath = _cwd + '/public/javascript/template';
var targetFileName = 'jade-template.js';
function compiler() {
    mkdirSync(targetPath);
    fs.readdir(sourcePath, function (err, files) {
        var allFunctions = [];
        _.forEach(files, function (file) {
            var jsFunctionString = jade.compileFileClient(sourcePath + '/' + file, {name: path.basename(file, '.jade').replace(/-/g, '_') + '_template'});
            allFunctions.push(jsFunctionString);
        });
        fs.writeFileSync(targetPath + '/' + targetFileName, allFunctions.join('\r\n'));
        console.log('compile jade template successfully: ' + targetPath + '/' + targetFileName);
    });
}

var mkdirSync = function (dirpath, mode) {
    dirpath.split('\/').reduce(function (pre, cur) {
        var p = path.resolve(pre, cur);
        if (!fs.existsSync(p)) fs.mkdirSync(p, mode || 0755);
        return p;
    }, __dirname);
};


module.exports = compiler();
```
以上代码意思是将项目目录下`views/pages`下的所有模板文件进行渲染，每个模板编译生成的函数名为`{filename}_template`，并且将所有生成的函数打包到项目目下下的`public/javascript/template`中的`jade-template.js`中。在客户端只需要引入此文件，并调用相应的函数即可生成指定html。

项目启动自动预编译

在`app.js`中插入以下代码

```
require('./app/utils/jade-util');
```

至此，每次启动项目时均会预编译所有指定jade模板文件。

## 注意事项

如果使用以下监视文件并重启项目的工具时，需要将编译目标文件夹忽略掉（本例为`public/javascript/template`），否则会无限重启。
