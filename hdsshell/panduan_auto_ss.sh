if [[ "$HDS_CURRENT_PATH" = "" ]];then        
    if [  -f "build/envsetup.sh" ]; then        #判断文件是否存在
        HDS_CURRENT_PATH=$PWD 
        export HDS_CURRENT_PATH   
        echo "当前路径为：$HDS_CURRENT_PATH"
        echo "build/envsetup.sh 存在  运行source build/envsetup.sh"
        source build/envsetup.sh
    fi           
fi                  

#该文件的作用的是如果当前目录是android 工程的根目录，那么先自动把当前目录赋值给HDS_CURRENT_PATH，并且执行envsetup.sh