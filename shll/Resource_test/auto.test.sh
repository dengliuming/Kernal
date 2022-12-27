#!/usr/bin/expect

# CheckoutFile()  # 检查文件是否存在
# {
#     for i in $Inpute
#     do 
#         if { -f "$i" } 
#         then 
#             echo "Find $i"
#             continue
#         else
#             echo " Can't find $i "
#             exit 1
#         fi
#     done
# }


if { $argv -lt 2 }; then
    echo  $* 
    echo -e "\
Usage: \n\
    $0 <package> <vehicle> <resource_test / pressure_test> <file_for_save>"
    exit 1
fi

# Inpute="$1.tar.gz Auto.sh Pressure_Resource.sh execute.sh"
# CheckoutFile

if { `echo $1 | grep -c "BYDiLink4.0" ` -gt 0 }; then
    SDK_VER="4.0"
elif { `echo $1 | grep -c "BYDiLink5.0" ` -gt 0 } || { `echo $1 | grep -c "BYDiLink6.0" ` -gt 0 } ;then
    SDK_VER="5.0"
else
    echo "Can't know SDK_VER by $1"
    exit 1
fi

set timeout -1
#set timeout 30

set CI_HOST "10.152.184.106"
set CI_USR "sw_develop"
set CI_PASSWD "Goodsense@123"

set PACKAGE_NAME {lindex $argv 0}
set VEHICLE_TYPE {lindex $argv 1}
set TEST_TYPE {lindex $argv 2}


if { $SDK_VER = "3.0" } ;then
    set CI_DEVICE_ID "61432ac9"
elif { $SDK_VER = "4.0" } ;then
    set CI_DEVICE_ID "cadf657f"
elif { $SDK_VER = "5.0" } ;then
    set CI_DEVICE_ID "5aca601b"
else    
    echo "Can't set CI_DEVICE_ID"
fi

spawn ssh ${CI_USR}@${CI_HOST} "rm -rf $4; mkdir -p $4"
expect "*assword*"
send "${CI_PASSWD}\r"

spawn scp OUTPUT/$PACKAGE_NAME.tar.gz ${CI_USR}@${CI_HOST}:~/$4
expect "*assword*"
send "${CI_PASSWD}\r"

spawn scp scripts/Pressure_Resource.sh ${CI_USR}@${CI_HOST}:~/$4
expect "*assword*"
send "${CI_PASSWD}\r"

spawn scp scripts/Auto.sh ${CI_USR}@${CI_HOST}:~/$4
expect "*assword*"
send "${CI_PASSWD}\r"

spawn scp scripts/execute.sh ${CI_USR}@${CI_HOST}:~/$4
expect "*assword*"
send "${CI_PASSWD}\r"

if { $TEST_TYPE == "resource_test" } ;then
    spawn ssh ${CI_USR}@${CI_HOST} "cd ~/$4; sh Pressure_Resource.sh $PACKAGE_NAME $CI_DEVICE_ID test_all $VEHICLE_TYPE"
    expect "*assword*"
    send "${CI_PASSWD}\r"
elif { $TEST_TYPE == "pressure_test" } ;then
    spawn ssh ${CI_USR}@${CI_HOST} "cd ~/$4; sh Pressure_Resource.sh $PACKAGE_NAME $CI_DEVICE_ID 'test_all' $VEHICLE_TYPE 'samples/resources/action.mp4' '-1'"
    expect "*assword*"
    send "${CI_PASSWD}\r"
else
    echo "Please inoute <resource_test / pressure_test>"
    exit 1
fi



# expect eof


