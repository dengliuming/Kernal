#############################################注意：文件保证是在与ohos同级的目录下source ./mm.sh################################################
#!/bin/bash
Current_Path(){
   echo ">>>>>> 获取当前路径并创建txt文件 <<<<<<"
   CRTDIR=$(pwd)
   touch All_Commit.txt
   touch listOK.txt
}
git_init(){
   echo ">>>>>> 创建的分支 <<<<<<"
   git branch aa
}
git_read(){
    echo ">>>>>> 获取git log内容 <<<<<<"
    LineNum=$(git log | grep "commit [0-9a-zA-Z]\{40\}" | awk 'BEGIN{count=0;} {commit[count]=$2;count++;} END{for(i=0;i<NR;i++) print i,commit[i]}' | grep -E "$f1|$f2" )
}
vi +':w ++ff=unix' +':q' ohos_code_base.txt  #将文件ohos_code_base从dos格式转为Unix
vi +':w ++ff=unix' +':q' listOK.txt
Current_Path
CRTDIR=$(pwd)   #保留当前目录
sed -r "s#.*(ohos)#\1#" ohos_code_base.txt>listOK.txt  #截取ohos2及之后的内容
while read LINE || [[ -n ${LINE} ]]
do 
   for dir in $LINE
   do
      if test -d $dir ; then               #判断是否是目录
         cd $dir
         pwd
         git_init                          #每cd进一个目录则进行一次分支创建
      else
         echo ">>>>>> 开始git操作 <<<<<<"
         git_read
         echo $LineNum | sed 's/ /\n/g '>$CRTDIR/All_Commit.txt #将获取的commit id移到All_Commit中
         echo ">>>>>> 开始reset id操作 <<<<<<"
         resule=`grep $LINE -B 0 $CRTDIR/All_Commit.txt`
         echo $resule
         git reset --hard $resule
         cd $CRTDIR
      fi
   done
done <listOK.txt
