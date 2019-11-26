# ubuntu_android_Develop
<pre>
注意:
1.这里的经验分享还没完成,可能有些还无法正常使用,后续继续完成
2.这些经验其实更加适合有点点经验的人提升效率使用.

这里主要是分享一些在ubuntu下面开发android 系统的经验，主要是一些工具的使用，加速开发,这里主要是分析一些
非常有用的脚本.
另外还会分享一些很实用的经验:
1.如何在终端单击打开文件,打开文件后同时自动调到想看的那一行.如何修改终端选中就是复制.
2.文件夹中右键添加安装apk菜单功能,不需要每次都输入adb install ***
3.使用鼠标如何右键把文件快速push到手机
4.插入usb链接adb,如果不弹出文件夹
5.介绍一个文件编辑编辑器vscode,我本人使用感觉比source insight(si)方便点,当然si也有比它强的地方.
  配合我写的脚本和我修改后的终端来使用,查看代码真的很方便.如果大量编辑android代码,当然,还是没有哪个编辑器能比的上androidstudio.
6.如何让命令行终端输入忽略大小写
7.如何让终端收藏一些常用命令,如何在终端快速输入历史的某个记录
8.gitk应用中如何复制文件路径
9.如何在命令行中使用androidstudio打开文件
10.ubuntu中如何做笔记最方便后续使用
11.文件夹中建议使用书签,如何在任何文件夹打开命令行终端
12.文件如何选择默认打开程序
13.如何在命令行下面单击打开图片

#安装
第一次安装使用hdsToolInstall.sh,后续重新安装,只需要同步更新hdsshell文件夹的文件即可.
安装方法:
下载好文件,进入ubuntu_android_Develop文件夹,执行./hdsToolInstall.sh,按照提示操作即可.


#使用方法:
安装好了之后,即可使用这些脚本.脚本在hdsshell文件夹中,再命令行下输入这些脚本的名字即可.

#hdsshell文件夹是开发中常用的脚本:

mtklog使用的脚本:
log             //删除设备中旧的mtklog,然后启动mtklog app,并且开始录制mtklog
logs            //用来停止录制mtklog,并且删除电脑上旧的mtklog,并且把android设备上面的mtklog pull到电脑上
说明:每次抓log,都输入*#*#3646633#*#*,然后找到mtklog,再启动抓log是很费力的.使用这里的脚本一步就完成了,很方便.

git常用脚本
gits            //该命令等于 git status -uno .       即是查询修改的文件status
gitstatus       //该命令等于 git status .            即是查询修改的文件和新添加的文件status
gls             //该命令用来通过关键字来搜查修改记录,该命令大小不敏感

查询文件内容的常用脚本(如果你很熟悉ack,那么可能不需要这些脚本,但是我认为ack的命令不好记忆,也没下面的命令输入快)
ff              //该命令用来查询当前目录所有文件,大小写敏感
ffw             //该命令用来查询当前目录所有文件,大小写敏感,和ff有何区别,就在用于ffw查询的是一个单词
ffi             //该命令用来查询当前目录所有文件,大小写不敏感
jg              //该命令用来查询当前目录java()文件,相当于android工程中的jgrep命令,却别就是jgrep仅限于android工程下面使用
mg              //该命令用来查询当前目录makefile()文件
gg              //该命令用来查询当前目录java文件  
xg              //该命令用来查询当前目录xml()文件
cg              //该命令用来查询当前目录c/cpp()文件,相当于android工程中的cgrep命令,却别就是cgrep仅限于android工程下面使用
g               //该命令用来查询当前目录某个类型的文件,需要提前设定文件类型
注:整个功能搜索是很费时间的,但是如果搜索某一类文件,那么效率会大大提高

如果还觉得上面的查询搜索有点慢,其实还有一招更快的,搜索整个工程秒查出来.但是也有缺陷.具体看使用说明


查询文件是否存在的脚本,查询到后显示路径
f.sh            //该命令用来快速文件,如果在android 工程下面查询,第一次查询可能慢,但是后面再查询任何文件都是立刻查询成功.
                //在android工程下,其实就是使用了源码中的godir命令的修改版,脚本会自动判断是否是在android工程下做查询.支持模糊和精确查询
                //如果不在android 工程下面查询,就是相当于用find命令递归查询当前目录

其他脚本
s.sh            //该脚本对应别名s,脚本相当于"source build/envsetup.sh && lunch",
                //同时记住当前目录,执行s后,即可使用bb命令
bb.sh           //返回工程根目录,需要配合s命令或者cd命令使用,该脚本对应别名bb
listcurrentdirfile
cd              //重写了系统的cd命令,加强了两方面:cd 完毕后自动执行ls命令,
                //如果cd进入的android工程,会自动执行source build/envsetup.sh,
                //envsetup.sh中的很多命令就可以使用了,另外还记住了android工程根目录,
                //cd到任何其他目录,输入bb就会返回android工程根目录


上面的经验详细分为两个文档来介绍:
1.脚本使用介绍
2.实用经验


如有问题请加qq群:
</pre>
