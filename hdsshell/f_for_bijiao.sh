
function find_fuction(){
    echo "  在当前目录下递归查询文件名中包含\"$1\"的文件,结果如下："
    echo "-------------------------------------------------"
    # find . -name "*$1*"
    find . -name .git -prune -o -name out -prune -o -type f -name "*$1*"
}
function hdsgodir () {
    # echo "hds:$1"
    if [[ -z "$1" ]]; then
        echo "文件名不能为空，请输入要查找的文件"
        return
    fi
    # 为了能够在工程下的每一个文件夹中使用这个脚本，还是配合了s和ss.sh脚本中的HDS_CURRENT_PATH变量

    #panduan_auto_ss.sh的作用的是如果当前目录是android 工程的根目录，那么先自动把当前目录赋值给HDS_CURRENT_PATH，并且执行envsetup.sh
    source panduan_auto_ss.sh

    HDS_CURRENT_PATH=$PWD
    if [[ "$HDS_CURRENT_PATH" = "" ]];then  
        echo "HDS_CURRENT_PATH == \"\"请先运行ss 或者s"
        find_fuction $1
    else
        my_pwd=$PWD

        strA=$my_pwd
        strB=$HDS_CURRENT_PATH
        is_project_dir="0"
        if [[ $strA == *$strB* ]]; then
            is_project_dir="1"
        fi
        if [  -f "build/envsetup.sh" ]; then
            is_project_dir="1"
        fi
        if [ "$is_project_dir" == "1" ]; then
            if [ "$1" == "c" ];then 
                echo "只查询当前目录"
                find_fuction $2
                return
            fi

            # echo "strA包含strB"

            local T=$HDS_CURRENT_PATH
            # echo "查询结果可以通过oo命令打开，当前查找的路径是:$T"
            # echo "第一个参数为ｃ表示只查询当前目录，如果为cc表示更大范围的模糊查询，没加参数，那么就是精确查询"
            local FILELIST
        
            FILELIST=$T/filelist
            # echo "FILELIST:$FILELIST"    FILELIST 文件列表的位置
            
            if [[ ! -f $FILELIST ]]; then
                echo -n "Creating index..."
                (\cd $T; find . -wholename ./.git -prune -o -wholename ./.repo -prune -o -type f > $FILELIST)
                echo " Done"
                echo ""
            fi
            local lines
            #| sed -e 's/\/[^/]*$//'

            # lines=($(\grep -F "$2" $FILELIST  | sort | uniq))
           
            if [ "$1" = "cc" ];then 
                lines=($(\grep -F "$2" $FILELIST  | sort | uniq))
            else
                lines=($(\grep -F "/$1" $FILELIST  | sort | uniq))
            fi
            if [[ ${#lines[@]} = 0 ]]; then
                echo "Not found"
                return
            fi
            local pathname
        
            local index=0
            local line
            ff_result_filter=$HDSHOME"/hdsjiaohuan/ff_result_filter.txt"
            rm $ff_result_filter
            touch $ff_result_filter
            for line in ${lines[@]}; do
                echo "$line" | tee $ff_result_filter
                index=$(($index + 1))
            done
            echo "------------------共查询到：$index 个文件"
        else
            # echo "strA不包含strB"
            echo "当前不是工程根目录"
            find_fuction $1
        fi
    fi
    

}
hdsgodir $@

