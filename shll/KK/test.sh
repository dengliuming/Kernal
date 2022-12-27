#!/bin/bash
Current_Path(){
   echo ">>>>>> 获取当前路径并创建txt文件 <<<<<<"
   CRTDIR=$(pwd)
   touch listOK.txt
}
vi +':w ++ff=unix' +':q' log.txt  #将文件ohos_code_base从dos格式转为Unix
vi +':w ++ff=unix' +':q' listOK.txt
COMPARE="d"
while read LINE || [[ -n ${LINE} ]]
do 
   for dir in $LINE
   do
      FINAL=${LINE: -1}
      if [ "${FINAL}" = "${COMPARE}" ] ; then               #判断是否是目录
          #echo ">>>>>> 第一组数据处理 <<<<<<"
          TT=${LINE:63:5}
          AA=${TT:0:2}
          BB=${TT:3:2}
          FIRST=$AA$BB
          FIRST_LAST=$((16#${FIRST}))
          #echo $FIRST_LAST
          #echo ">>>>>> 第二组数据处理 <<<<<<"
          HH=${LINE:93:5}
          CC=${HH:0:2}
          DD=${HH:3:2}
          SECOND=$CC$DD
          SECOND_LAST=$((16#${SECOND}))
          hi_2=$FIRST_LAST"-"$SECOND_LAST
          echo $hi_2>>listOK.txt     #获取第一组数据
          break;
      fi
   done
done <log.txt
