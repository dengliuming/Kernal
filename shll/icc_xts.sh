###
 # @Description  
 # @Version  1.0
 # @Autor  dengliuming
 # @Date  2021-12-114 16:28:00
 # @LastEditors dengliuming
 # @LastEditTime 2021-12-114 16:28:00
### 
#!/bin/bash

CRTDIR=$(pwd)    #当前目录
product_id=$1
test_a="CONFIG_FACTORY_TEST_SUPPORT=y"
test_b="CONFIG_HILINK=y"
test_b1="#CONFIG_HILINK=y"
Usr_Config_Path=$CRTDIR/device/hisilicon/hi3861/sdk_liteos/build/config/	#获取usr_config.mk所在路径
# 删除test_a="CONFIG_FACTORY_TEST_SUPPORT=y"
# test_b="CONFIG_HILINK=y"
# test_b1="#CONFIG_HILINK=y"
Delete_Usr_Config(){
    cd $Usr_Config_Path
    #file=$Usr_Config_Path/usr_config.mk
    vi +':w ++ff=unix' +':q' usr_config.mk    #将文件usr_config.mk从dos格式转为Unix
    while read LINE || [[ -n ${LINE} ]]
    do 
        if [ "$LINE" = "$test_a" ] || [ "$LINE" = "$test_b" ] || [ "$LINE" = "$test_b1" ] ; then
            echo ">>>>>>delete CONFIG_FACTORY_TEST_SUPPORT and CONFIG_HILINK<<<<<<<<"
            sed -i '/'"$LINE"'/d' usr_config.mk
        fi
    done <usr_config.mk
	cd $CRTDIR
}

Re_Usr_Config(){
    cd $Usr_Config_Path
	vi +':w ++ff=unix' +':q' usr_config.mk    #将文件usr_config.mk从dos格式转为Unix
    if ! grep "$test_a" usr_config.mk ; then    #寻找是否存在test_b
    #不存在，添加字符串
        echo ">>>>>>>>>>Add $test_a<<<<<<<<<<"
        sed -i '$a\'$test_a usr_config.mk
    fi
	if ! grep "$test_b" usr_config.mk ; then    #寻找是否存在test_b
    #不存在，添加字符串
        echo ">>>>>>>>>>Add $test_b<<<<<<<<<<"
        sed -i '$a\'$test_b usr_config.mk
    fi
	cd $CRTDIR
}

# 添加CONFIG_HILINK=y
Add_Usr_Config(){
    cd $Usr_Config_Path
	vi +':w ++ff=unix' +':q' usr_config.mk    #将文件usr_config.mk从dos格式转为Unix
    if ! grep "$test_b" usr_config.mk ; then    #寻找是否存在test_b
    #不存在，添加字符串
        echo ">>>>>>>>>>Add $test_b<<<<<<<<<<"
        sed -i '$a\'$test_b usr_config.mk
    fi
	cd $CRTDIR
}

# 删除defines = \[ "TOKEN_PERSIST_TEST" \]
kitframework_TOKEN_PERSIST_TEST='defines = \[ "TOKEN_PERSIST_TEST" \]'	#需要删除的内容
TOKEN_PERSIST_TEST_Path=$CRTDIR/test/xts/acts/applications/kitframework
Delete_Build(){
    cd $TOKEN_PERSIST_TEST_Path	#进入BUILD.gn所在目录
    vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
    if grep "$kitframework_TOKEN_PERSIST_TEST" BUILD.gn ; then 
        echo ">>>>>>>>>>Delete $kitframework_TOKEN_PERSIST_TEST<<<<<<<<<<"
        sed -i '/'"$kitframework_TOKEN_PERSIST_TEST"'/d' BUILD.gn	#删除内容
    fi
	cd $CRTDIR
}
# 添加defines = \[ "TOKEN_PERSIST_TEST" \]
Add_Build(){
    cd $TOKEN_PERSIST_TEST_Path	#进入BUILD.gn所在目录
	vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
	if ! grep "$kitframework_TOKEN_PERSIST_TEST" BUILD.gn ; then
        # sed -i '/# un-comment this Macro for token-persist-test/{:a;n;s/#defines = \[ "TOKEN_PERSIST_TEST" \]/defines = \[ "TOKEN_PERSIST_TEST" \]/g;/\}/!ba}' BUILD.gn
        echo ">>>>>>>>>>Add $kitframework_TOKEN_PERSIST_TEST<<<<<<<<<<"
        sed -i '/# un-comment this Macro for token-persist-test/a\       defines = \[ "TOKEN_PERSIST_TEST" \]' BUILD.gn
    fi
	cd $CRTDIR
}

########注意，需确保文件中存在这些目录
t1='"//test/xts/acts/communication_lite/lwip_hal:ActsLwipTest",'
t2='"//test/xts/acts/communication_lite/softbus_hal:ActsSoftBusTest",'
t3='"//test/xts/acts/communication_lite/wifiservice_hal:ActsWifiServiceTest",'
t4='"//test/xts/acts/utils_lite/file_hal:ActsUtilsFileTest",'
t5='"//test/xts/acts/startup_lite/syspara_hal:ActsParameterTest",'
t6='"//test/xts/acts/iot_hardware_lite/iot_controller_hal:ActsWifiIotTest",'
t7='"//test/xts/acts/kernel_lite/kernelcmsis_hal:ActsCMSISTest",'
t8='"//test/xts/acts/utils_lite/kv_store_hal:ActsKvStoreTest",'
t9='"//test/xts/acts/security_lite/datahuks_hal:ActsSecurityDataTest",'
t10='"//test/xts/acts/hiviewdfx_lite/hilog_hal:ActsDfxFuncTest",'
t11='"//test/xts/acts/distributed_schedule_lite/samgr_hal:ActsSamgrTest",'
t12='"//test/xts/acts/update_lite/updater_hal:ActsUpdaterFuncTest",'
t13='"//test/xts/acts/startup_lite/bootstrap_hal:ActsBootstrapTest",'
t14='"//test/xts/acts/applications/kitframework:ActsKitFwkApiTest",'

T1='#"//test/xts/acts/communication_lite/lwip_hal:ActsLwipTest",'
T2='#"//test/xts/acts/communication_lite/softbus_hal:ActsSoftBusTest",'
T3='#"//test/xts/acts/communication_lite/wifiservice_hal:ActsWifiServiceTest",'
T4='#"//test/xts/acts/utils_lite/file_hal:ActsUtilsFileTest",'
T5='#"//test/xts/acts/startup_lite/syspara_hal:ActsParameterTest",'
T6='#"//test/xts/acts/iot_hardware_lite/iot_controller_hal:ActsWifiIotTest",'
T7='#"//test/xts/acts/kernel_lite/kernelcmsis_hal:ActsCMSISTest",'
T8='#"//test/xts/acts/utils_lite/kv_store_hal:ActsKvStoreTest",'
T9='#"//test/xts/acts/security_lite/datahuks_hal:ActsSecurityDataTest",'
T10='#"//test/xts/acts/hiviewdfx_lite/hilog_hal:ActsDfxFuncTest",'
T11='#"//test/xts/acts/distributed_schedule_lite/samgr_hal:ActsSamgrTest",'
T12='#"//test/xts/acts/update_lite/updater_hal:ActsUpdaterFuncTest",'
T13='#"//test/xts/acts/startup_lite/bootstrap_hal:ActsBootstrapTest",'
T14='#"//test/xts/acts/applications/kitframework:ActsKitFwkApiTest",'
Kit_Build=$CRTDIR/test/xts/acts/build_lite	#进入BUILD.gn所在目录

# 初始注释掉行
De_Kit_Build(){	#将所以非’#‘的带上’#‘
    cd $Kit_Build
    vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
    while read LINE || [[ -n ${LINE} ]]
    do 
        if [ "$LINE" = "$t1" ] ; then
            echo ">>>>>>Delete $T1<<<<<<<<"
            sed -i 's!'"$t1"'!'"$T1"'!g' BUILD.gn
        else 
            echo "Fall to delete($t1)"
        fi
		if [ "$LINE" = "$t2" ] ; then
            echo ">>>>>>Delete $T2<<<<<<<<"
            sed -i 's!'"$t2"'!'"$T2"'!g' BUILD.gn
        else 
            echo "Fall to delete($t2)"
        fi
		if [ "$LINE" = "$t3" ] ; then
            echo ">>>>>>Delete $T3<<<<<<<<"
            sed -i 's!'"$t3"'!'"$T3"'!g' BUILD.gn
        else 
            echo "Fall to delete($t3)"
        fi
		if [ "$LINE" = "$t4" ] ; then
            echo ">>>>>>Delete $T4<<<<<<<<"
            sed -i 's!'"$t4"'!'"$T4"'!g' BUILD.gn
        else 
            echo "Fall to delete($t4)"
        fi	
		if [ "$LINE" = "$t5" ] ; then
            echo ">>>>>>Delete $T5<<<<<<<<"
            sed -i 's!'"$t5"'!'"$T5"'!g' BUILD.gn
        else 
            echo "Fall to delete($t5)"
        fi
		if [ "$LINE" = "$t6" ] ; then
            echo ">>>>>>Delete $T6<<<<<<<<"
            sed -i 's!'"$t6"'!'"$T6"'!g' BUILD.gn
        else 
            echo "Fall to delete($t6)"
        fi
		if [ "$LINE" = "$t7" ] ; then
            echo ">>>>>>Delete $T7<<<<<<<<"
            sed -i 's!'"$t7"'!'"$T7"'!g' BUILD.gn
        else 
            echo "Fall to delete($t7)"
        fi
		if [ "$LINE" = "$t8" ] ; then
            echo ">>>>>>Delete $T8<<<<<<<<"
            sed -i 's!'"$t8"'!'"$T8"'!g' BUILD.gn
        else 
            echo "Fall to delete($t8)"
        fi		
		if [ "$LINE" = "$t9" ] ; then
            echo ">>>>>>Delete $T9<<<<<<<<"
            sed -i 's!'"$t9"'!'"$T9"'!g' BUILD.gn
        else 
            echo "Fall to delete($t9)"
        fi	
		if [ "$LINE" = "$t10" ] ; then
            echo ">>>>>>Delete $T10<<<<<<<<"
            sed -i 's!'"$t10"'!'"$T10"'!g' BUILD.gn
        else 
            echo "Fall to delete($t10)"
        fi
		if [ "$LINE" = "$t11" ] ; then
            echo ">>>>>>Delete $T11<<<<<<<<"
            sed -i 's!'"$t11"'!'"$T11"'!g' BUILD.gn
        else 
            echo "Fall to delete($t11)"
        fi
		if [ "$LINE" = "$t12" ] ; then
            echo ">>>>>>Delete $T12<<<<<<<<"
            sed -i 's!'"$t12"'!'"$T12"'!g' BUILD.gn
        else 
            echo "Fall to delete($t12)"
        fi
		if [ "$LINE" = "$t13" ] ; then
            echo ">>>>>>Delete $T13<<<<<<<<"
            sed -i 's!'"$t13"'!'"$T13"'!g' BUILD.gn
        else 
            echo "Fall to delete($t13)"
        fi
		if [ "$LINE" = "$t14" ] ; then
            echo ">>>>>>Delete $T14<<<<<<<<"
            sed -i 's!'"$t14"'!'"$T14"'!g' BUILD.gn
        else 
            echo "Fall to delete($t14)"
        fi	
    done <BUILD.gn
	cd $CRTDIR
}

# 释放#"//test/xts/acts/applications/kitframework:ActsKitFwkApiTest",
Re_Kit_Build(){    #将指定的#行换成非#行
    cd $Kit_Build
    vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
    if grep "$T14" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t14<<<<<<<<<<"
        sed -i 's!'"$T14"'!'"$t14"'!g' BUILD.gn
    fi
	cd $CRTDIR
}

# 释放：T1~T13
Re_Kit_Build_os(){
    cd $Kit_Build
    vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
    if grep "$T1" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t1<<<<<<<<<<"
        sed -i 's!'"$T1"'!'"$t1"'!g' BUILD.gn
    fi
	if grep "$T2" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t2<<<<<<<<<<"
        sed -i 's!'"$T2"'!'"$t2"'!g' BUILD.gn
    fi
	if grep "$T3" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t3<<<<<<<<<<"
        sed -i 's!'"$T3"'!'"$t3"'!g' BUILD.gn
    fi
	if grep "$T4" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t4<<<<<<<<<<"
        sed -i 's!'"$T4"'!'"$t4"'!g' BUILD.gn
    fi
	if grep "$T5" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t5<<<<<<<<<<"
        sed -i 's!'"$T5"'!'"$t5"'!g' BUILD.gn
    fi
	if grep "$T6" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t6<<<<<<<<<<"
        sed -i 's!'"$T6"'!'"$t6"'!g' BUILD.gn
    fi
	if grep "$T7" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t7<<<<<<<<<<"
        sed -i 's!'"$T7"'!'"$t7"'!g' BUILD.gn
    fi
	if grep "$T8" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t8<<<<<<<<<<"
        sed -i 's!'"$T8"'!'"$t8"'!g' BUILD.gn
    fi
	if grep "$T9" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t9<<<<<<<<<<"
        sed -i 's!'"$T9"'!'"$t9"'!g' BUILD.gn
    fi
	if grep "$T10" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t10<<<<<<<<<<"
        sed -i 's!'"$T10"'!'"$t10"'!g' BUILD.gn
    fi
	if grep "$T11" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t11<<<<<<<<<<"
        sed -i 's!'"$T11"'!'"$t11"'!g' BUILD.gn
    fi
	if grep "$T12" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t12<<<<<<<<<<"
        sed -i 's!'"$T12"'!'"$t12"'!g' BUILD.gn
    fi
	if grep "$T13" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t113<<<<<<<<<<"
        sed -i 's!'"$T13"'!'"$t13"'!g' BUILD.gn
    fi
	cd $CRTDIR
}

#释放T1
Re_Kit_Build_T1(){
    cd $Kit_Build
    vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
    if grep "$T1" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t1<<<<<<<<<<"
        sed -i 's!'"$T1"'!'"$t1"'!g' BUILD.gn
    fi
	cd $CRTDIR
}

#释放T3
Re_Kit_Build_T3(){
    cd $Kit_Build
    vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
	if grep "$T3" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t3<<<<<<<<<<"
        sed -i 's!'"$T3"'!'"$t3"'!g' BUILD.gn
    fi
	cd $CRTDIR
}

#释放T4
Re_Kit_Build_T4(){
    cd $Kit_Build
    vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
	if grep "$T4" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t4<<<<<<<<<<"
        sed -i 's!'"$T4"'!'"$t4"'!g' BUILD.gn
    fi
	cd $CRTDIR
}

#释放T7
Re_Kit_Build_T7(){
    cd $Kit_Build
    vi +':w ++ff=unix' +':q' BUILD.gn    #将文件BUILD.gn从dos格式转为Unix
	if grep "$T7" BUILD.gn ; then 
        echo ">>>>>>>>>>Add $t7<<<<<<<<<<"
        sed -i 's!'"$T7"'!'"$t7"'!g' BUILD.gn
    fi
	cd $CRTDIR
}


Appli='#"applications",'

# 添加"applications",
Add_Utils(){       
    cd $CRTDIR/test/xts/tools/lite/build/
	vi +':w ++ff=unix' +':q' utils.py
	if grep "$Appli" utils.py ; then
        echo ">>>>>>Add applications<<<<<<<<"
        sed -i '/_NO_FILTE_SUB_SYSTEM_LIST/{:a;n;s/#"applications",/"applications",/g;/\]/!ba}' utils.py
    fi
	cd $CRTDIR
}
# 注释#"applications",
Delete_Utils(){
    cd $CRTDIR/test/xts/tools/lite/build/
	vi +':w ++ff=unix' +':q' utils.py
	echo ">>>>>>already exist applications<<<<<<<<"
	if ! grep "$Appli" usr_config.mk ; then    #寻找是否存在test_b
	    echo ">>>>>>Add $Appli<<<<<<<<"
        sed -i '/_NO_FILTE_SUB_SYSTEM_LIST/{:a;n;s/"applications",/#"applications",/g;/\]/!ba}' utils.py
    fi
	cd $CRTDIR
}

Acts='{ "component": "xts_acts", "features":\[\] \},'
Tools='{ "component": "xts_tools", "features":\[\] \}'

#添加 { "component": "xts_acts", "features":[] },
# { "component": "xts_tools", "features":[] }
Add_Config_File(){
    cd $CRTDIR/vendor/chinasoft/$product_id/
    vi +':w ++ff=unix' +':q' config.json
	sed -i '/"subsystem": "test",/{:a;n;s/"components": \[/"components": \[\n        \{ "component": "xts_acts", "features":\[\] \},\n        \{ "component": "xts_tools", "features":\[\] \}/g;/\]/!ba}' config.json
    cd $CRTDIR
}
# 删除{ "component": "xts_acts", "features":[] },
# { "component": "xts_tools", "features":[] }
Delete_Config_File(){
    cd $CRTDIR/vendor/chinasoft/$product_id/
    vi +':w ++ff=unix' +':q' config.json
	if grep "$Acts" config.json ; then
        sed -i '/'"$Acts"'/d' config.json
    fi
	if grep "$Tools" config.json ; then
        sed -i '/'"$Tools"'/d' config.json
    fi
	cd $CRTDIR
}

#删除enable_wifi_info
Enable1='"enable_wifi_info = true"'
Enable2='"enable_wifi_info = false"'
Delete_wifi_iot_app(){
    # cd $CRTDIR/vendor/chinasoft/$product_id/
	vi +':w ++ff=unix' +':q' $CRTDIR/vendor/chinasoft/$product_id/config.json
    sed -i 's!'"$Enable1"'!'"$Enable2"'!g' $CRTDIR/vendor/chinasoft/$product_id/config.json
	# cd $CRTDIR
}

#添加enable_wifi_info
Re_wifi_iot_app(){
    # cd $CRTDIR/vendor/chinasoft/$product_id/
	vi +':w ++ff=unix' +':q' $CRTDIR/vendor/chinasoft/$product_id/config.json
	sed -i 's!'"$Enable2"'!'"$Enable1"'!g' $CRTDIR/vendor/chinasoft/$product_id/config.json
	# cd $CRTDIR
}

Extern='extern unsigned char mymac_addr\[12\];'
Add_Hal(){
    cd $CRTDIR/vendor/chinasoft/$product_id/hals/utils/sys_param/
    vi +':w ++ff=unix' +':q' hal_sys_param.c
	sed -i '/'"$Extern"'/d' hal_sys_param.c
	sed -i '/printf("HalGetSerial\[%s\]\\r\\n",mymac_addr);/,/return OHOS_SERIAL;/d' hal_sys_param.c  #删除原来内容
	sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     return value;' hal_sys_param.c     #在//return value;后面添加内容
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     }' hal_sys_param.c 
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         return NULL;' hal_sys_param.c 
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         free(value);' hal_sys_param.c 
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     if (strcpy_s(value, strlen(OHOS_SERIAL) + 1, OHOS_SERIAL) \!= 0) {' hal_sys_param.c 
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     }' hal_sys_param.c 
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\         return NULL;' hal_sys_param.c 
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     if (value == NULL) {' hal_sys_param.c 
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\     char\* value = (char\*)malloc(strlen(OHOS_SERIAL) + 1);' hal_sys_param.c 
	cd $CRTDIR
}

Val='\/\/ char\* value = (char\*)malloc(strlen(OHOS_SERIAL) + 1);'
Re_Hal(){
    cd $CRTDIR/vendor/chinasoft/$product_id/hals/utils/sys_param/
    vi +':w ++ff=unix' +':q' hal_sys_param.c 
	sed -i '/'"$Val"'/d' hal_sys_param.c
    sed -i '/char\* value = (char\*)malloc(strlen(OHOS_SERIAL) + 1);/,/return value;/d' hal_sys_param.c  #删除原来内容
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\    return OHOS_SERIAL;' hal_sys_param.c      #在//return value;后面添加内容
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\    }' hal_sys_param.c
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\        return NULL;' hal_sys_param.c
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\    if (strcpy_s(OHOS_SERIAL, strlen(mymac_addr) + 1, mymac_addr) \!= 0) {' hal_sys_param.c
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\    printf("HalGetSerial\[%s\]\\r\\n",mymac_addr);' hal_sys_param.c
    sed -i '\/\/ strcpy(OHOS_SERIAL,mymac_addr);/a\    extern unsigned char mymac_addr\[12\];' hal_sys_param.c
	cd $CRTDIR
}


#判断是否在$CRTDIR/vendor/chinasoft/$product_id/处存在out文件
M_out(){
    cd $CRTDIR/vendor/chinasoft/$product_id/
    if [ ! -d "out" ]; then
      mkdir out
    fi
}

help(){
    echo "usage: $sh_name [command] <options>
    >>>>>>>>>>>>>>>>>>first<<<<<<<<<<<<<<<<<<
    all                         运行所有
    short                       短距固件包
    kit_1                       kitframework_1固件包
    kit_2                       kitframework_2固件包
    os_1                        os兼容固件包
    os_c                        os_communication_lite
    os_w                        os_wifiservice_hal
    os_k                        os_kernel_lite
    os_u                        os_utils_lite
    >>>>>>>>>>>>>>>>>>second<<<<<<<<<<<<<<<<<<
    Please 'hb set' enter the project(you want)!
    >>>>>>>>>>>>>>>>>>example<<<<<<<<<<<<<<<<<<
    ./test.sh S1H1 -a short        默认选的工程项目S1H1
    ./test.sh S1H1 short           自己选工程项目
    " 
}

error_echo(){
    echo "Parameter error,Please enter '$sh_name help' to know more."
}

Target_Path=$CRTDIR/vendor/chinasoft/$product_id/out

short(){
    echo ">>>>>>>>>>>短距固件包：<<<<<<<<<<<"
    Delete_Usr_Config
    Delete_wifi_iot_app
    Add_Hal
    hb build -f
    Re_Hal
    Re_wifi_iot_app
    Re_Usr_Config
    cd $CRTDIR/out/hi3861/$product_id/
    echo `mv Hi3861_wifiiot_app_allinone.bin Hi3861_short_1.bin`
    echo `mv Hi3861_short_1.bin $Target_Path`
    cd $CRTDIR
}

kit_1(){
    echo ">>>>>>>>>>>kitframework_1固件包：<<<<<<<<<<<"
    Delete_Usr_Config
    Add_Usr_Config
    Delete_Build
    De_Kit_Build
    Re_Kit_Build
    Add_Utils
    Add_Config_File
    hb build -f
	
    Re_Usr_Config
    Add_Build
    De_Kit_Build
    Delete_Utils
    Delete_Config_File
    cd $CRTDIR/out/hi3861/$product_id
    echo `mv Hi3861_wifiiot_app_allinone.bin kitframework_1.bin`
    echo `mv kitframework_1.bin $Target_Path`
    cd $CRTDIR
}

kit_2(){
    echo ">>>>>>>>>>>kitframework_2固件包：<<<<<<<<<<<"
    Add_Build
    hb build -f
    cd $CRTDIR/out/hi3861/$product_id
    echo `mv Hi3861_wifiiot_app_allinone.bin kitframework_2.bin`
    echo `mv kitframework_2.bin $Target_Path`
    cd $CRTDIR
}

os_1(){
    echo ">>>>>>>>>>>os兼容固件包:<<<<<<<<<<<"
    Delete_Config_File
    Add_Config_File
    De_Kit_Build
    Re_Kit_Build_os
    Delete_Usr_Config
    Delete_wifi_iot_app
    Add_Hal
    hb build -f
    Delete_Config_File
    De_Kit_Build
    Re_Usr_Config
    Re_wifi_iot_app
    Re_Hal
    cd $CRTDIR/out/hi3861/$product_id
    echo `mv Hi3861_wifiiot_app_allinone.bin Hi3861_os_1.bin`
    echo `mv Hi3861_os_1.bin $Target_Path`
    cd $CRTDIR
}

os_c(){
    echo ">>>>>>>>>>>os_communication_lite.bin:<<<<<<<<<<<"
    De_Kit_Build
    Re_Kit_Build_T1
    hb build -f
    De_Kit_Build
    cd $CRTDIR/out/hi3861/$product_id
    echo `mv Hi3861_wifiiot_app_allinone.bin os_communication_lite.bin`
    echo `mv os_communication_lite.bin $Target_Path`
    cd $CRTDIR
}

os_w(){
    echo ">>>>>>>>>>>os_wifiservice_hal.bin:<<<<<<<<<<<"
    De_Kit_Build
    Re_Kit_Build_T3
    hb build -f
    De_Kit_Build
    cd $CRTDIR/out/hi3861/$product_id
    echo `mv Hi3861_wifiiot_app_allinone.bin os_wifiservice_hal.bin`
    echo `mv os_wifiservice_hal.bin $Target_Path`
    cd $CRTDIR
}

os_k(){
    echo ">>>>>>>>>>>os_kernel_lite.bin:<<<<<<<<<<<"
    De_Kit_Build
    Re_Kit_Build_T7
    hb build -f
    De_Kit_Build
    cd $CRTDIR/out/hi3861/$product_id
    echo `mv Hi3861_wifiiot_app_allinone.bin os_kernel_lite.bin`
    echo `mv os_kernel_lite.bin $Target_Path`
    cd $CRTDIR
}

os_u(){
    echo ">>>>>>>>>>>os_utils_lite.bin：<<<<<<<<<<<"
    De_Kit_Build
    Re_Kit_Build_T4
    hb build -f
    De_Kit_Build
    cd $CRTDIR/out/hi3861/$product_id
    echo `mv Hi3861_wifiiot_app_allinone.bin os_utils_lite.bin`
    echo `mv os_utils_lite.bin $Target_Path`
    cd $CRTDIR
}




if [ $# = 1 ];then
    if [ $1 = "help" ];then
        help
    else
        error_echo
    fi
elif [ $# = 2 ];then
    M_out
    hb set
    if [ $2 = "all" ];then
        short
        kit_1
        kit_2
        os_1
        os_c
        os_w
        os_k
        os_u
    elif [ $2 = "short" ];then
        short
    elif [ $2 = "kit_1" ];then
        kit_1
    elif [ $2 = "kit_2" ];then
        kit_2
    elif [ $2 = "os_1" ];then
        os_1
    elif [ $2 = "os_c" ];then
        os_c
    elif [ $2 = "os_w" ];then
        os_w
    elif [ $2 = "os_k" ];then
        os_k
    elif [ $2 = "os_u" ];then
        os_u
    else
        error_echo
    fi
elif [ $# = 3 ];then
    M_out
    checkout_mode=$2
    if [ $checkout_mode = "-a" ]; then
        hb set -p $product_id chinasoft
        if [ $3 = "all" ];then
            short
            kit_1
            kit_2
            os_1
            os_c
            os_w
            os_k
            os_u
        elif [ $3 = "short" ];then
            short
        elif [ $3 = "kit_1" ];then
            kit_1
        elif [ $3 = "kit_2" ];then
            kit_2
        elif [ $3 = "os_1" ];then
            os_1
        elif [ $3 = "os_c" ];then
            os_c
        elif [ $3 = "os_w" ];then
            os_w
        elif [ $3 = "os_k" ];then
            os_k
        elif [ $3 = "os_u" ];then
            os_u
        else
            error_echo
        fi
    else
        error_echo
    fi
else
    error_echo
fi