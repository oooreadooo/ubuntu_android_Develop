HDS_CURRENT_PATH=$PWD
export HDS_CURRENT_PATH             #记住当前目录用于bb命令
if [ ! -f "build/envsetup.sh" ]; then        #判断文件是否存在
    echo "当前路径为：$HDS_CURRENT_PATH，请用bb命令返回当前目录"
else
    echo "当前路径为：$HDS_CURRENT_PATH，该命令可以不再android工程中运行，用于记住当前目录，通过bb命令返回"
    echo "build/envsetup.sh 存在  运行source build/envsetup.sh && lunch命令"
    source build/envsetup.sh && lunch
fi


