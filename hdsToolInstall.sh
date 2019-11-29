HDS_temp_CURRENT_PATH=$PWD
\cd       #进入home
ishdsDebug="1"   #是否进行debug
HDS_temp_CURRENT_home_PATH=$HOME
hdsjiaohuan_dir=$HDS_temp_CURRENT_home_PATH"/hdsjiaohuan/"

hdshuangjingbianliangfilepath="$HDS_temp_CURRENT_home_PATH""/.bashrc"
if [ "$ishdsDebug" == "1" ]; then
    hdshuangjingbianliangfilepath="$HDS_temp_CURRENT_home_PATH""/.bashrc_2"
fi

hdsshelldir="$HDS_temp_CURRENT_home_PATH""/ubuntu_android_Develop/"
hdsshelldir2="$HDS_temp_CURRENT_home_PATH""/ubuntu_android_Develop"


#---------------------检查环境变量文件是否存在
if [  -f "$hdshuangjingbianliangfilepath" ]; then        #判断要添加环境变量的文件是否存在 
    echo "  "  
else      
    echo "  $hdshuangjingbianliangfilepath 文件不存在,后续需要把环境变量添加到该文件夹
    停止安装"
    exit 0
fi   

is_first_time_install="1"            #第一次安装,全部所有动作,后续安装只同步部分脚本
if [ -d "$hdsjiaohuan_dir" ]; then
    if [ -d "$hdsshelldir2/hdsshell" ]; then
        is_first_time_install="0"    #//不是第一次安装
    fi
fi


if [ "$is_first_time_install" == "0" ]; then    #不是第一次安装,只做文件同步
    cp -rf $HDS_temp_CURRENT_PATH/* $hdsshelldir
    if [ "$ishdsDebug" == "0" ]; then
        cd "$hdsshelldir2/hdsshell"
        echo "当前目录是:$PWD"
        if [  -f "../hdsToolInstall.sh" ]; then        #判断这个文件的存在,确保前面复制已经完成
            echo "sudo  chmod 777 -R ."
            sudo  chmod 777 -R .
            echo "sudo  chmod 777 -R .    runing succ"
        else 
            echo "文件不存在"
        fi  
    fi

    echo "本次安装因不是第一次安装,只同步部分文件,已完成
    "

else   #第一次安装
#---------------------创建临时文件夹,用来临时交换文件的
    mkdir "$hdsjiaohuan_dir"
    cd  "$hdsjiaohuan_dir"
    touch jianqieban_info.txt ff_result_filter.txt jianqieban_oo_info.txt cpfilelist_tmp.sh gtag.txt
    touch cpfilelist.sh jiaohuan.txt ff_result.txt ff_result_temp.txt jianqieban_info_common.txt jiaohuan_temp.txt

    
#---------------------复制脚本
    ismakesure="no"
    read -p  "  后续将会把相关脚本安装在:$hdsshelldir  路径下.接下来将会进行安装[yes/no]" ismakesure
    echo "  "
    if [ "$ismakesure" == "yes" ]; then
        mkdir "$hdsshelldir"
        cp -rf $HDS_temp_CURRENT_PATH/* $hdsshelldir
        cd "$hdsshelldir2/hdsshell"
        # echo "$hdsshelldir2/hdsshell"
        echo "当前目录是:$PWD"
        if [  -f "../hdsToolInstall.sh" ]; then        #判断这个文件的存在,确保前面复制已经完成
            echo "sudo  chmod 777 -R ."
            sudo  chmod 777 -R .
            echo "sudo  chmod 777 -R .    runing succ"
        else 
            echo "文件不存在"
        fi  
        
    else
        echo "  user cancel !"
        exit 0
    fi
#---------------------添加环境变量


    echo "  接下来将会添加脚本运行的环境变量到文件:$hdshuangjingbianliangfilepath"
    echo "
    #hds start
    export HDSDATAAAA=$hdsshelldir"/hdsshell"
    export HDSHOME=$HDS_temp_CURRENT_home_PATH
    export PATH=\$HDSHOME:\$HDSDATAAAA:\$PATH
    alias bb='source bb.sh'
    alias s='source s.sh'
    alias f='source f.sh'
    alias cd='source cd'
    alias c='c.sh'
    alias m='m -j12  2>&1 |tee hdslog.txt'
    alias b='cd ..'
    #hds end"

    read -p  "  是否添加如上环境变量(第一次安装选择 yes)[yes/no]" ismakesure1
    echo "  "
    if [ "$ismakesure1" == "yes" ]; then
    echo "
    #hds start
    export HDSDATAAAA=$hdsshelldir"/hdsshell"
    export HDSHOME=$HDS_temp_CURRENT_home_PATH
    export PATH=\$HDSHOME:\$HDSDATAAAA:\$PATH
    alias bb='source bb.sh'
    alias s='source s.sh'
    alias f='source f.sh'
    alias cd='source cd'
    alias c='c.sh'
    alias m='m -j12  2>&1 |tee hdslog.txt'
    alias b='cd ..'
    #hds end" >> $hdshuangjingbianliangfilepath
    echo "环境变量添加成功"
    fi
    source $hdshuangjingbianliangfilepath



#--------------------- 安装常用必须的app
    echo "为了某些脚本能够顺利运行,这里先安装如下工具(这些工具不会影响mtk和高通的编译,已经验证,请放心使用):"
    echo "
    sudo apt-get install meld
    sudo apt-get install tree
    sudo apt-get install nautilus-open-terminal
    sudo apt-get install xsel
    sudo apt-get install xclip"
    read -p  "  是否安装[yes/no]" ismakesure2
    echo "  "
    if [ "$ismakesure2" == "yes" ]; then
        sudo apt-get install meld
        sudo apt-get install tree
        sudo apt-get install nautilus-open-terminal
        sudo apt-get install xsel
        sudo apt-get install xclip
    else
        echo "  user cancel install!"
    fi

    echo "本次安装是本程序第一次安装,已完成
    "
fi


