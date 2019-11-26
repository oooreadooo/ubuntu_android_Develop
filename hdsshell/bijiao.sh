if [ "$1" == "c" ]; then 
    echo "该shell的用法:
    比如有两个工程:1./dpan/28  2./dpan/29
    现在把/dpan/29/frameworks/base/Android.mk对比到a28工程相应的文件
    操作步骤如下:
    cd /dpan/29
    bj c /dpan/28                     //alias bj='source bijiao.sh'
    bj frameworks/base/Android.mk

    步骤完成,比较的结果是
    bcompare frameworks/base/Android.mk /dpan/28/frameworks/base/Android.mk
    
    "
    compare_project_home_dir=$2
    if [ "$compare_project_home_dir" == "" ]; then
        echo "  输入不能为空"
    else
        if [ -d "$compare_project_home_dir" ]; then
            FINAL_char=${compare_project_home_dir: -1}
            if [ "$FINAL_char" == "/" ]; then
                compare_project_home_dir=${compare_project_home_dir%/*}  #去掉最后的/     %/* 表示从右边开始，删除第一个 / 号及右边的字符
            fi
            echo "  你输入的工程根目录为:$compare_project_home_dir"
            export compare_project_home_dir
        else
            echo "  你输入的目录不存在,只能输入绝对路径"
        fi
    fi
    
else
    youcomparfile=$1
    other_path_start=${youcomparfile:0:2}
    if [ "$other_path_start" == "./" ]; then
        youcomparfile=${youcomparfile#*./}   #去掉 "./"
    fi
    if [ -f "$youcomparfile" ]; then
        #这里后续需要考虑输入的路径结尾是否带了/
        otherprojectfile="$compare_project_home_dir""/$youcomparfile"
        if [ -f "$otherprojectfile" ]; then
            echo "bcompare $youcomparfile $otherprojectfile"
            bcompare $youcomparfile $otherprojectfile
        else
            echo "  你要比较的文件不存在:$otherprojectfile"
            echo "  该同名文件在工程中可能不在同一个位置了"
            echo "  在$compare_project_home_dir 目录查询该文件路径结果如下:"
            hdsfilename=${otherprojectfile##*/}     #这里是从路径截取文件名
            HDS_temp_CURRENT_PATH=$PWD
            \cd $compare_project_home_dir
            # echo "cd $compare_project_home_dir"
            f_for_bijiao.sh $hdsfilename
            \cd $HDS_temp_CURRENT_PATH
            read -p   "  是否找到了文件,如果找到了,请复制路径继续比较:" otherprojectfile
            if [ "$compare_project_home_dir" == "" ]; then
                echo "  输入为空,已取消"
            else
                other_path_start=${otherprojectfile:0:2}
                if [ "$other_path_start" == "./" ]; then
                    otherprojectfile=${otherprojectfile#*./}   #去掉 "./"
                fi
                otherprojectfile="$compare_project_home_dir""/$otherprojectfile"
                if [ -f "$otherprojectfile" ]; then
                    bcompare $youcomparfile $otherprojectfile
                else
                    echo "  你要比较的文件不存在:$otherprojectfile, 可能复制路径错误"
                fi
            fi
        fi
    else
        echo "  你要比较的文件不存在:$youcomparfile"
    fi
fi

#该shell的用法 比如有两个工程:1./dpan/28  2./dpan/29
# 现在把/dpan/29/frameworks/base/Android.mk对比到a28工程相应的文件
# 操作步骤如下:
# cd /dpan/29
# source bijiao.sh c /dpan/28
# bijiao.sh frameworks/base/Android.mk

# 步骤完成,比较的结果是
# bcompare frameworks/base/Android.mk /dpan/28/frameworks/base/Android.mk

