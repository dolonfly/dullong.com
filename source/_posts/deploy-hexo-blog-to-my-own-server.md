title: 部署 hexo 静态博客到自有服务器
date: 2016-01-15 20:49:56
tags:
- hexo
- server

---

hexo 是一个快速、简洁且高效的博客框架。

主要有以下特点：

* 超快速度
* 支持 Markdown
* 一键部署
* 丰富的插件

本文不介绍hexo的安装及使用方法，仅介绍怎么将渲染后的静态文件部署至自有的服务器上。

本文目标：

* 通过`hexo d -g`命令将静态博客部署到自有服务器

<!-- more -->

## 配置ssh

安装 `Homebrew` :

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

> Homebrew is the missing package manager for OS X

安装 `ssh-copy-id`:

```
brew install ssh-copy-id
```

> ssh-copy-id命令可以把本地的ssh公钥文件安装到远程主机对应的账户下

执行如下命令

```
$ ssh-copy-id user@host
```

其中将`user`替换为自己服务器用户名，`host`替换为对应的ip地址。通过此命令可以将本地的ssh公钥发送到目标主机上，然后登陆主机账户即可免密码登陆。

通过以下命令校验ssh免密登陆配置成功：

`ssh user@host echo "test"`

控制台输出`test`即表名配置成功


## 配置hexo部署命令

在`package.js`中的`dependencies`下加入以下代码：

```
"hexo-deployer-rsync": "git+https://github.com/dolonfly/hexo-deployer-rsync.git"
```

执行：

```
npm install
```

为`_config.yml`配置以下：

```
deploy:
- type: rsync
  host: 121.40.253.109
  user: dll
  root: /data/www/dullong.com/
  port: 22
  delete: false
```
本配置为本人服务器的配置，替换为自己的即可。

测试：

```
hexo d -g
```

运行此命令即进行将文档渲染为静态文件，并发送到`121.40.253.109`的`/data/www/dullong.com/`目录下。

登陆主机，对应文件夹内存在`public`文件夹内内容即表名配置手动部署成功。

## 配置通过域名访问

* 安装`nginx`
* 配置`nginx`server主机为`www.dullong.com`并将`root`目录设置为`/data/www/dullong.com/`
* 将域名`www.dullong.com`A记录解析到`121.40.253.109`
* 通过`http://www.dullong.com`即可访问到本人静态博客

> 如果自有的服务器为国内主机，则需要先备案才能成功解析