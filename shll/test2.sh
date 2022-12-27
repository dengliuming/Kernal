#!/bin/bash


CRTDIR=$(pwd)  

M_out(){
    cd $CRTDIR/
    if [ ! -d "out" ]; then
      mkdir out
    fi
}

M_out


# checkout_product(){
    # company="hisilicon"
    # company_path="./vendor/$company"
	# product_id=$1
	# hb set -p $product_id hi3861
# }

# checkout_product


















# kitframework_TOKEN_PERSIST_TEST='defines = \[ "TOKEN_PERSIST_TEST" \]'	#需要删除的内容
# Add_Build(){
    # # cd $TOKEN_PERSIST_TEST_Path	#进入BUILD.gn所在目录
	# # vi +':w ++ff=unix' +':q' test1.txt    #将文件BUILD.gn从dos格式转为Unix
	# if grep "$kitframework_TOKEN_PERSIST_TEST" test1.txt ; then
        # sed -i '/# un-comment this Macro for token-persist-test/{:a;n;s/#defines = \[ "TOKEN_PERSIST_TEST" \]/defines = \[ "TOKEN_PERSIST_TEST" \]/g;/\}/!ba}' test1.txt
    # else
        # sed -i '/# un-comment this Macro for token-persist-test/a\        defines = \[ "TOKEN_PERSIST_TEST" \]' test1.txt
    # fi
# }

# Add_Build



# sed -i '/# un-comment this Macro for token-persist-test/a\        defines = \[ "TOKEN_PERSIST_TEST" \]' test1.txt














#删除行间内容
# sed -i '/extern unsigned char mymac_addr\[12\];/,/return value;/d' test1.txt
# sed -i '/char\* value = (char\*)malloc(strlen(OHOS_SERIAL) + 1);/,/return value;/d' test1.txt
# Extern='extern unsigned char mymac_addr\[12\];'
# Add_Hal(){
    # cd $CRTDIR/vendor/hisilicon/hi3861/hals/utils/sys_param/
    # vi +':w ++ff=unix' +':q' test1.txt 
	# sed -i '/'"$Extern"'/d' hal_sys_param.c
	# sed -i '/printf("HalGetSerial\[%s\]\\r\\n",mymac_addr);/,/return value;/d' hal_sys_param.c  #删除原来内容
	# sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     return value;' hal_sys_param.c     #在//return value;后面添加内容
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     }' hal_sys_param.c 
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         return NULL;' hal_sys_param.c 
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         free(value);' hal_sys_param.c 
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     if (strcpy_s(value, strlen(OHOS_SERIAL) + 1, OHOS_SERIAL) \!= 0) {' hal_sys_param.c 
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     }' hal_sys_param.c 
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         return NULL;' hal_sys_param.c 
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     if (value == NULL) {' hal_sys_param.c 
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     char\* value = (char\*)malloc(strlen(OHOS_SERIAL) + 1);' hal_sys_param.c 
# }

# Re_Hal(){
    # cd $CRTDIR/vendor/hisilicon/hi3861/hals/utils/sys_param/
    # vi +':w ++ff=unix' +':q' hal_sys_param.c 
    # sed -i '/char\* value = (char\*)malloc(strlen(OHOS_SERIAL) + 1);/,/return value;/d' hal_sys_param.c  #删除原来内容
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     return value;' hal_sys_param.c      #在//return value;后面添加内容
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     }' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         return NULL;' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         free(value);' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     if (strcpy_s(value, strlen(mymac_addr) + 1, mymac_addr) \!= 0) {' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     }' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         return NULL;' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     if (value == NULL) {' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     char\* value = (char\*)malloc(strlen(mymac_addr) + 1);' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     printf("HalGetSerial\[%s\]\\r\\n",mymac_addr);' hal_sys_param.c
    # sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     extern unsigned char mymac_addr\[12\];' hal_sys_param.c
# }
# Re_Hal










# sed -i 's/123//g' test1.txt

# sed -i '/char* HalGetSerial\(void\)/{:a;n;s/extern unsigned char mymac_addr\[12\];/aaaaaaa/g;/return value;/!ba}' test1.txt


t3='aaaaaaa'
t4='extern unsigned char mymac_addr\[12\];'

# sed -i '/char* HalGetSerial\(void\)/{:a;n;s/${t4}/${t3}/g;/return value;/!ba}' test1.txt

# sed -i 's#'"$t2"'#'"$t1"'#g' test1.txt















# sed -i '/# un-comment this Macro for token-persist-test/a\        defines = \[ "TOKEN_PERSIST_TEST" \]' test1.txt
# if grep "$t1" test1.txt ; then
    # sed -i '/# un-comment this Macro for token-persist-test/{:a;n;s/#defines = \[ "TOKEN_PERSIST_TEST" \]/defines = \[ "TOKEN_PERSIST_TEST" \]/g;/\}/!ba}' test1.txt
# else
    # sed -i '/# un-comment this Macro for token-persist-test/a\        defines = \[ "TOKEN_PERSIST_TEST" \]' test1.txt
# fi


# sed -i '/"subsystem": "test",/{:a;n;s/"components": \[/"components": \[\n\{ "component": "xts_acts", "features":\[\] \},\n\{ "component": "xts_tools", "features":\[\] \}/g;/\]/!ba}' test1.txt

#指定某行间替换
# sed -i '/"subsystem": "test",/{:a;n;s/"components": \[/"components": \[\n        \{ "component": "xts_acts", "features":\[\] \},\n        \{ "component": "xts_tools", "features":\[\] \}/g;/\]/!ba}' test1.txt


# sed -i '/"subsystem": "test",/{:a;n;s/\]/{ "component": "xts_acts", "features":\[\] \},\n        \{ "component": "xts_tools", "features":\[\] \}\n        \]/g;/\}/!ba}' test1.txt

#指定，某下一行插入
# sed -i '/"components": \[/a\        \{ "component": "xts_acts", "features":\[\] \},\n        \{ "component": "xts_tools", "features":\[\] \}' test1.txt

# sed -i '/"subsystem": "test",/{:a;n;s/\{ "component": "xts_acts", "features":\[\] \},//!ba}' test1.txt

# Acts='{ "component": "xts_acts", "features":\[\] \},'
# Tools='{ "component": "xts_tools", "features":\[\] \}'


# if grep "$Acts" test1.txt ; then
    # sed -i '/'"$Acts"'/d' test1.txt
# fi
# if grep "$Tools" test1.txt ; then
    # sed -i '/'"$Tools"'/d' test1.txt
# fi

# sed -i '/_NO_FILTE_SUB_SYSTEM_LIST/{:a;n;s/#"applications",/"applications",/g;/\]/!ba}' utils.py

# set ssss = "`grep "$t1" test1.txt`"
# awk -v sub_text="$ssss" '{if ($1 == "$t2") print sub_text; else print $0}' test1.txt

# t1='"applications",'
# T1='#"applications",'
# while read LINE || [[ -n ${LINE} ]]
# do 
    # if [ "$LINE" = "$t1" ] ; then
        # echo ">>>>>>already exist $t1<<<<<<<<"
    # else 
        # echo "Fall to delete(nothing these)"
    # fi
# done <test1.txt


# t1='aaa ='
# t2='bbb'
# t3='ccc
# vvv'
# if grep "$t1" test1.txt ; then 
    # echo "input file"
    # # sed -i 's;"$SYSTEM_LIST;$SYSTEM_LIST1";g'	 test1.txt
	# # sed -i 's!'"$SYSTEM_LIST"'!'"$SYSTEM_LIST1"'!g' test1.txt
	# # sed "s"/"$SYSTEM_LIST""/""$SYSTEM_LIST1""/g" test1.txt
	# # sed -i 's#'"$t2"'#'"$t1"'#g' test1.txt
	# sed -i '/$t1/{:a;n;'s/'"$t2"'/'"$t3"'/g';'/'sada'/'!ba}' test1.txt
# fi




# for((i=1;i<=3;i++)); 
# do  
# if grep "T$i" BUILD.gn ; then 
    # echo "input file"
    # sed -i 's!'"T$i"'!'"t$i"'!g' BUILD.gn
	# #sed -i '/'"$te"'/d' test1.txt
# fi
# done


# if grep "$T3" BUILD.gn ; then 
    # echo "input file"
    # sed -i 's!'"$T3"'!'"$t3"'!g' BUILD.gn
	# #sed -i '/'"$te"'/d' test1.txt
# fi

	

# if ! grep -q "$Kit_Test" test1.txt ; then 
    # echo "Nothoing"
    
	# #sed -i '/'"$Kit_Test"'/d' BUILD.gn 
	# # sed -i 's/'"$Kit_Test"'/'"$Kit_Test1"'/g' BUILD.gn
# else
    # echo "input file"
    # sed -i 's/'"$Kit_Test"'/'"$Kit_Test1"'/g' test1.txt
# fi

# sed -i 's/'"$Kit_Test"'/'"$Kit_Test1"'/g' BUILD.gn
# while read LINE || [[ -n ${LINE} ]]
# do 
    # if [ "$LINE" = "$Kit_Test" ] ; then
        # echo ">>>>>>delete CONFIG_FACTORY_TEST_SUPPORT and CONFIG_HILINK<<<<<<<<"
        # # sed -i 's/'"$LINE"'/'"$Kit_Test1"'/g' test1.txt
        # sed -i '/'"$LINE"'/d' test1.txt
    # else 
        # echo "Fall to delete(nothing these)"
    # fi
# done <test1.txt

# Te='defines = \[ "cc" \]'
# RE="AAA"
# if grep "$Te" test1.txt ; then 
    # echo "input file"
    # sed -i 's/'"$Te"'/'"$RE"'/g' test1.txt
	# #sed -i '/'"$te"'/d' test1.txt
# else
	# echo "Nothoing"
# fi
