ff_result=$HDSHOME"/hdsjiaohuan/ff_result.txt"
ff_result_temp=$HDSHOME"/hdsjiaohuan/ff_result_temp.txt"
ff_result_filter=$HDSHOME"/hdsjiaohuan/ff_result_filter.txt"
function get_all_filepath_to_file(){
        #下一行是去掉所有颜色相关的标签
        sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"  "$ff_result" > "$ff_result_temp"

        echo "" >> "$ff_result_temp"
        rm "$ff_result_filter"
        touch "$ff_result_filter"
        find_file_count=0
        while read line
        do

            if [[ "$line" = "" ]];then        
                # echo "$line"
                continue
            fi


            #二进制文件不支持打开
            strA=$line
            strB="匹配到二进制文件"
            #判断是否包含有“：”
            if [[ $strA =~ $strB ]]            
            then
                # echo "$line  不支持打开"
                continue
            fi


            # echo "    line："$line
            strA=$line
            strB=":"
            line_left=""
            hdsfilepath=""
            hdsfileline=""
            #判断是否包含有“：”
            if [[ $strA =~ $strB ]]            
            then
                #下一行是截取：左边的字符串
                line_left=${line%%:*}
                hdsfilepath=$line_left
                # echo "    line："$line

                #考虑打开文件的时候，跳到指定的行
                # line_right=${var#*//}
                # 其中 var 是变量名，# 号是运算符，*// 表示从左边开始删除第一个 // 号及左边的所有字符
                #下一行是截取：右边的字符串
                line_right=${line#*:}
                if [[ "$line" != "" ]];then     
                    #下一行是截取：左边的字符串
                    line_right=${line_right%%:*}   
                    hdsfileline=$line_right
                    # line="$line_left:$line_right"
                fi
            else
                # echo "not line："$line
                echo ""
                hdsfilepath=$line
            fi
            # echo "    hdsfilepath:"$hdsfilepath
            #要判断前一行所指向的文件是否相同
            if [ "$oldfilepath" == "$hdsfilepath" ] ;then
                oldfilepath=$hdsfilepath
                #echo "路径:$line   已打开"
                continue
            fi
            # 判断文件是否存在
            oldfilepath=$hdsfilepath


            if [ -f "$hdsfilepath" ];then
                #echo "路径:$line   存在"
                # echo "$line" >> "$ff_result_filter"

                if [[ "$hdsfileline" == "" ]];then 
                    echo "$hdsfileline" >> "$ff_result_filter"
                else
                    echo "$hdsfilepath:$hdsfileline" >> "$ff_result_filter"
                fi



                let find_file_count+=1
            else
                if [ -d "$line" ];then
                    echo "路径:$line   存在，但文件夹不会被打开"
                fi
            fi

        done < "$ff_result_temp"

        echo "" >> "$ff_result_filter"
        echo "--------------------------------------------------------------------------------------------end"
        echo "                      共查询到： $find_file_count 个文件"
}

get_all_filepath_to_file

#这个shell的作用是把ff 命令搜索到的文件保存在ff_result_filter路径中，方便后面的打开
# alias ff='grep -r -n'
# alias fff='grep -r -i -n'
# alias ffw='grep -r -n -w'   
