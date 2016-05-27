###LLDB(Low Level Debugger)
* 内置于Xcode中的动态调试工具,通吃C,C++,OC,全盘支持OSX,iOS,iOS模拟器
* 在指定的条件下启动程序;
* 在指定的条件下停止程序;
* 在程序停止的时候检查程序内部发生的事;
* 在程序停止的时候对程序进行改动,观察程序的执行过程有什么变化

LLDB是运行在OSX中的,要想调试iOS,需要和debugserver进行配合.
debugserver运行在iOS上,作为服务器,实际上执行LLDB传过来的命令,再把执行结果反馈给LLDB,显示给用户,即所谓的远程调试,默认iOS设备上并没有debugserver,只有在设备连接一次Xcode,在Windows-->Device菜单中添加此设备后, debugserver才会被Xcode安装到iOS的"/Developer/usr/bin/"目录下.


---->上述是正向开发调试用的,劳资要逆向......
逆向要配置debugserver+LLDB

![操作步骤](http://o7pqb42yk.bkt.clouddn.com/%E6%AD%A5%E9%AA%A4.jpg)

* 1.将未处理的debugserver拷贝到/User/esirnus下
* 2.帮它瘦身(ps:我也🐘➖✈️)
* 3.去<http://iosre.com/ent.xml>下载ent.xml然后拷贝到/User/esirnus下,给debugserver添加task_for_pid权限,注意-Sent.xml之间没有空格
* 4.将经过处理的debugserver拷贝回iOS的/usr/bin目录下
* 5.ssh到iOS
* 6.给拷贝回的debugserver添加权限
* 没有将debugserver拷贝回原文件夹,一是因为/Developer/usr/bin下的原版debugserver是不可写的,二是因为/usr/bin下的命令无须输入全路径就可以执行,即在任意目录下运行debugserver都可以启动处理多的debugserver.


###debugserver最常用的是启动和附加进程

* debugserver会启动executable,并开启port端口,等待来自IP的LLDB的接入

~~~
debugserver -x backboard IP:port /path/to/executable
~~~

* debugserver会附加ProcessName,并开启port端口,等待来自IP的LLDB的接入

~~~
debugserver IP:port -a "ProcessName"
~~~

eg:启动AppStore,并开启1234端口,等待任意的IP地址的LLDB接入
debugserver -x backboard 192.168.35.252:1234 /Applications/AppStore.app/AppStore

eg:会附加AppStore,并开启1234端口,等待任意的IP地址的LLDB接入
debugserver 192.168.35.252:1234 -a "AppStore"

ps:两个注意点:1.一定要开启端口号(:1234),1234端口号是自己指定的;2.iOS上的"/Develpoer/"目录下缺少必要的调试数据,这种情况一般是没有在Xcode中添加设备,在Xcode-->Window-->Devices菜单中添加设备(靠....切记切记,折腾了一天,😢);

配置好debugserver后启动Xcode的LLDB就可以调试了(注:X6的lldb有bug,在armv7和armv7s上设备上有事会混淆ARM和THUMB指令,导致无法调试,X7已修复)

![启动连接命令](http://o7pqb42yk.bkt.clouddn.com/1DBBE39E-D211-4B7F-86FD-5E246E6CBFB2.png)
通过此命令启动后,耗时较长,在进程停止后就可以开始调试了

LLDB命令 image list


























