
ff_result=$HDSHOME"/hdsjiaohuan/ff_result.txt"

function ggrep()
{
    
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.gradle" \
        -exec grep --color=always -nH "$@" {} +
    mangrep $@
    echo  "支持查询的类型为:gradle AndroidManifest.xml"
}

function jgrep()
{
    #kt 是kotlin
    
    find . -name .repo -prune -o  -name .git -prune -o -name out -prune -o -type f \( -name "*\.java" -o -name '*.kt' -o -name '*.aidl' \) \
        -exec grep --color=always -nH "$@" {} +
    # find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.java" \
    #     -exec grep --color=always -n "$@" {} +
    echo  "支持查询的类型为:java kt aidl"
}
function jgrepw()
{
    #kt 是kotlin
    
    find . -name .repo -prune -o    -name .git -prune -o -name out -prune -o -type f \( -name "*\.java" -o -name '*.kt' -o -name '*.aidl' \) \
        -exec grep --color=always -nHw "$@" {} +
    # find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.java" \
    #     -exec grep --color=always -n "$@" {} +
    echo  "支持查询的类型为:java kt aidl"
}

function mangrep()
{
    
    find . -name .repo -prune -o -name .git -prune -o -path out -prune -o -type f -name 'AndroidManifest.xml' \
        -exec grep --color=always -nH "$@" {} +
    echo  "支持查询的类型为:AndroidManifest.xml"
}
function mgrep()
{
    
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f \( -name '*.mk' -o -name '*.mak' -o -name '*kefile' -o -name '*.make' -o -name '*.sh' -o -name '*.bp'  -o -name '*.go' \)  \
        -exec grep --color=always -nH "$@" {} +
    echo "支持查询的类型为: mk mak kefile make bp go sh"
}
function mgrepw()
{
    
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f \( -name '*.mk' -o -name '*.mak' -o -name '*kefile' -o -name '*.make' -o -name '*.sh' -o -name '*.bp'  -o -name '*.go' \)  \
        -exec grep --color=always -nHw "$@" {} +
    echo "支持查询的类型为: mk mak kefile make bp go sh"
}

function cgrep()
{
    
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) \
        -exec grep --color=always -nH "$@" {} +
        echo "支持查询的类型为: c cc cpp h hpp"
}
function xgrep()
{
    
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.xml" \
        -exec grep --color=always -nH "$@" {} +
    echo "支持查询的类型为: xml"

        # find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.xml"  -exec grep --color=always -n "$@" {} +
}
function cgrepw()
{
    
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) \
        -exec grep --color=always -nHw "$@" {} +
        echo "支持查询的类型为: c cc cpp h hpp"
}
function xgrepw()
{
    
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.xml" \
        -exec grep --color=always -nHw "$@" {} +
    echo "支持查询的类型为: xml"

        # find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.xml"  -exec grep --color=always -n "$@" {} +
}
#该函数是根据给的后缀名来搜索文件的
function hdsgrep()
{
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.$1" \
        -exec grep --color=always -nH "$2" {} +
    
}
function hdsgrepw()
{
    find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.$1" \
        -exec grep --color=always -nHw "$2" {} +
    
}

function grepp_function(){
    $@    | tee "$ff_result"
}

echo "cg=cgrep C/C++   jg=jgrep java    mgrep=mgrep makefile  gg=ggrep Gradle and AndroidManifest.xml xg=xmlgrep"
echo "--------------------------------------------------------------------------------------------stard"
grepp_function $@

#    $@：表示所有的参数

#grep 的参数-H表示就算只有一个文件也显示文件名,没加-H之前查询单个文件不显示文件名

# find的参数:
# -not            #非，取反
# -user           #文件所有人
# -group          #文件所有组
# -a              #并且关系
# -o              #或者关系
# -prune          #排除该文件夹

