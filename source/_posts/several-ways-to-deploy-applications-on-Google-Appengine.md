title: 在Google Appengine上部署应用的几种方式
date: 2013-09-04 01:55:42
tags:
---

   
对于想使用云平台活着体验一下云平台的用户来说， google的appengine是一个不错的选择。 它提供了强大的功能和几乎免费的实例。对于学习来说绰绰有余。下面来简单介绍一下将自己的应用部署到appengine上的几种方法。

总体来说，有两种方法：直接通过google提供的上传脚本和通过eclipse的插件两种方法来上传。

<!-- more -->
 
## 准备工作

    
* 下载和安装java环境，下载Tomcat 6，可baidu或Google，不再赘述

* 下载 appengine sdk，我的版本为 appengine-java-sdk-1.7.4，作用提供模拟云环境及上传等功能。

* 文本编辑器，如 notepad++ 等。

* 一个已经编写成功的web应用（符合appengine规范）


### 通过google SDK中的插件进行上传

将appengine-java-sdk-1.7.4解压，并将其bin目录加入环境变量,定位到应用文件夹,执行命令 （其中WebContent为项目目录）`appcfg.cmd update WebContent`即可将WebContent作为项目文件夹上传上去。
 
### 使用eclipse插件进行上传

如果使用Eclipse，最简便的 App Engine 应用程序开发、测试和上传方法是使用Eclipse 插件。该插件包含完全在 Eclipse 中构建、测试和部署应用程序所需的所有功能。

该插件适用于 Eclipse 3.3、3.4 和 3.5 版。您可以使用 Eclipse 的“软件更新”功能安装该插件。安装位置如下所示：

* 用于 Eclipse 3.3 (Europa) 的 Eclipse Google 插件：http://dl.google.com/eclipse/plugin/3.3
* 用于 Eclipse 3.4 (Ganymede) 的 Eclipse Google 插件：http://dl.google.com/eclipse/plugin/3.4
* 用于 Eclipse 3.5 (Galileo) 的 Eclipse Google 插件：http://dl.google.com/eclipse/plugin/3.5

具体安装步骤同其他常用插件一样，如若不懂请自行google之

####  创建一个Google Appengine项目

* 选择文件菜单 > 新建 > 网络应用程序项目（如果没有看到该菜单选项，请选择窗口菜单 > 重置视角...，点击确定，然后再次尝试选择文件菜单）。或者，点击工具栏中的“新建网络应用程序项目”按钮：“新建网络应用程序项目”按钮。

* 将打开“创建网络应用程序项目”向导。在“项目名称”中输入项目的名称，

* 如果使用软件更新功能安装 App Engine SDK，则已将插件配置为使用安装的 SDK。如果要使用单独的 App Engine SDK 安装，请点击配置 SDK...，然后按照提示在 SDK 的 appengine-java-sdk/ 目录中添加配置。

* 点击完成以创建项目。

* 编写项目代码（同普通java ee代码一样。只是做了一些限制，比如不能创建新等等对安全有隐患的操作之类）

#### 将项目上传到google Appengine上

* Google Eclipse 插件在 Eclipse 工具栏中添加了几个按钮。App Engine 部署按钮用于将应用程序上传到 App Engine：App Engine 部署按钮。

* 第一次上传应用程序之前，必须使用控制台在 App Engine 中注册应用程序 ID。注册一个应用程序 ID，然后编辑 appengine-web.xml 文件并更改 <application>...</application> 元素以包含新 ID。

* 在点击 App Engine 部署按钮时，Eclipse 将提示您输入管理员帐户用户名（您的电子邮件地址）和密码。输入您的帐户信息，然后点击上传按钮以完成上传。Eclipse 将从appengine-web.xml 文件中获取应用程序 ID 和版本信息，然后上传 war/ 目录内容。

* 通过访问应用程序网址，在 App Engine 上测试应用程序：`http://应用ID.appspot.com/项目名`
 
## 参考文档

https://developers.google.com/appengine/docs/java/tools/uploadinganapp?hl=zh-cn
https://developers.google.com/appengine/docs/java/tools/eclipse?hl=zh-cn
 
 