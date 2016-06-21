title: Install OpenOffice and running OpenOffice as service from the command line on mac osx
date: 2016-06-21 22:36:59
tags:
---

`OpenOffice`是`Apache`基金会旗下的一款先进的开源办公软件套件，包含文本文档、电子表格、演示文稿、绘图、数据库等。包含`Microsoft office`所有功能。它不仅可以作为桌面应用供普通用户使用，也提供了完善的功能供开发者使用。`OpenOffice`可以作为服务方式启动供外部程序调用，进行文档转码等工作。

本文将介绍如何安装`OpenOffice`并将其作为服务启动供外部程序调用。

## 安装 Homebrew 及 Homebrew-Cask

`Homebrew` 是一个`Mac`上的包管理工具。使用`Homebrew`可以很轻松的安装缺少的依赖。

`Homebrew-Cask`是建立在`Homebrew`基础上的软件安装命令行工具,最新版本的`Homebrew`已集成此工具。

使用以下命令安装`Homebrew`

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 安装 OpenOffice

通过以下命令安装最新版的`OpenOffice`

```
brew cask install openoffice
```

此命令会将`OpenOffice`安装到`/usr/local/Caskroom`目录下

## 以服务方式启动`OpenOffice`

将`OpenOffice`加入用户环境变量

首先将`soffice`链接到`~/bin`目录下

```
cd ~/bin
ln -s /Applications/OpenOffice.app/Contents/MacOS/soffice ./
```

使用以下命令启动`OpenOffice`

```
soffice -headless -accept="socket,host=localhost,port=8100;urp;" -nofirststartwizard
```

此命令将已服务的方式启动`OpenOffice`，并监听本机的`8100`端口

## 参考链接

- [OpenOffice official website](https://www.openoffice.org/qa/qadevOOo_doc/user-guide.html)
- [Homebrew](http://brew.sh/)
- [Homebrew-Cask](https://caskroom.github.io/)