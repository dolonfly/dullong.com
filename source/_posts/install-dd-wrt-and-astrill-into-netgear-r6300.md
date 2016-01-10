title: install dd-wrt and astrill into netgear r6300
date: 2015-08-23 22:54:30
tags:
---


## Step 1. install DD-WRT



The whole detail can refer to [Netgear_R6300v2](http://www.dd-wrt.com/wiki/index.php/Netgear_R6300v2)



## Step 2. open ssh for DD-WRT and set no_crossdetect is true 



1. connect to your router and set sshd enabled.

2. go to telnet/ssh console and type `nvram set no_crossdetect=1 nvram commit`

refer:[Would like ability to turn off "Cross Site Action detected" error](http://svn.dd-wrt.com/ticket/1483)  

note: the feature is introduced in [r14962](http://svn.dd-wrt.com/changeset/14962). to prevent bad configs , i will not implement it as gui configurable feature.



## Step 3. install astrill vpn 



1. login your astrill account,if you have no astrill account ,you need reg one first.

2. go [router setup](https://members.astrill.com/router-setup.php) and select your firmware as DD-WRT and edit your router ip.

3. click install button,and the astrill code will install to your dd-wrt router system.



## Step 4. configure astrill



1. login to your router

2. select the `status` tab and then click `MyPage` tab,and it will in astrill configure page

