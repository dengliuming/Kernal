#!/bin/bash

Init()
{
    rm -rf drive.txt
    rm -rf drive_silver.txt
    rm -rf faceid.txt
    rm -rf faceid_silver.txt
    rm -rf err.txt 
}

PullLog()
{
    if [ "${test_whate}" = "test_all" ]; then
        adb -s ${vehicle_id} pull ${vehicle_path}/${package}/drive.txt
        adb -s ${vehicle_id} pull ${vehicle_path}/${package}/drive_silver.txt
        adb -s ${vehicle_id} pull ${vehicle_path}/${package}/faceid.txt
        adb -s ${vehicle_id} pull ${vehicle_path}/${package}/faceid_silver.txt
    else
        adb -s ${vehicle_id} pull ${vehicle_path}/${package}/${test_whate}.txt
        adb -s ${vehicle_id} pull ${vehicle_path}/${package}/${test_whate}_silver.txt
    fi
    adb -s ${vehicle_id} pull ${vehicle_path}/${package}/err.txt 
}

PushPack()  # 将文件推入车机
{
    echo " adb -s ${vehicle_id} push ${package} ${vehicle_path}"
    adb -s ${vehicle_id} push ${package}.tar.gz ${vehicle_path}
    # adb -s ${vehicle_id} shell ${BUSYBOX} tar -zxvf ${vehicle_path}/${package}.tar.gz
    echo "Push Auto.sh..."
    adb -s ${vehicle_id} root
    adb -s ${vehicle_id} remount
    adb -s ${vehicle_id} push Auto.sh ${vehicle_path}/
    adb -s ${vehicle_id} push execute.sh ${vehicle_path}/
    adb -s ${vehicle_id} shell chmod +x ${vehicle_path}/Auto.sh
    adb -s ${vehicle_id} shell chmod +x ${vehicle_path}/execute.sh
    echo "==== ${number_of_parameters}"
    if [ ${number_of_parameters} -eq 7 ]; then
        echo "Running samples_for_test..."
        adb -s ${vehicle_id} shell sh ${vehicle_path}/Auto.sh ${vehicle_path} ${package} ${vehicle} ${test_whate} ${video_path} ${count}
        PullLog
    elif [ ${number_of_parameters} -eq 5 ]; then
        echo "Running resource_test..."
        adb -s ${vehicle_id} shell sh ${vehicle_path}/Auto.sh ${vehicle_path} ${package} ${vehicle} ${test_whate}
        PullLog
    else
        echo "Unknown"
        exit 1
    fi
}

CheckoutFile()  # 检查文件是否存在
{
    for i in $Inpute
    do 
        if [ -f "$i" ] 
        then 
            echo "Find $i"
            continue
        else
            echo " Can't find $i "
            exit 1
        fi
    done
}

if [ $# -lt 5 ]; then
    echo  $* 
    echo -e "\
Usage: \n\
    资源占用:
                $0 <package> <vehicle_id> <vehicle_path> <test_whate[test_all、drive、faceid]> <vehicle> \n\
    压力测试:
                $0 <package> <vehicle_id> <vehicle_path> <test_whate[test_all、test_FaceID...]> <vehicle> <video_path> <count:-1 or > 0>"
    exit 1
fi

number_of_parameters=$#
Inpute="$1.tar.gz Auto.sh execute.sh"
CheckoutFile

if [ $# -eq 7 ]; then
    package=$1
    vehicle_id=$2
    vehicle_path=$3
    test_whate=$4
    vehicle=$5
    video_path=$6
    count=$7
elif [ $# -eq 5 ]; then
    package=$1
    vehicle_id=$2
    vehicle_path=$3
    test_whate=$4
    vehicle=$5
else
    echo "Unknown"
    exit 1
fi

Init

# 将文件推入车机
PushPack
