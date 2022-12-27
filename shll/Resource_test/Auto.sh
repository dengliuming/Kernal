#!/bin/bash

Check()
{
    result=`echo $?`
    if [ result -ne 0 ] ;then
        echo " [ Run .... FAILE ]"
        logcat -d >> err.txt 
        exit 1
    else 
        echo " [ Run .... OK ]"
    fi
}

Run()
{
    if [ "${test_whate}" = "test_all" ]; then
        echo "Run test_${Tmp_type}...."
        ./test/samples_for_test/bin/test_${Tmp_type} ${video_path} 25
        Check
        echo "Run test_FaceID...."
        echo "FaceID : register"
        ./test/samples_for_test/bin/test_FaceID 0 ${video_path} 25 ./face.db ./ 5
        Check
        echo "FaceID : login"
        ./test/samples_for_test/bin/test_FaceID 1 ${video_path} 25 ./face.db ./ 5
        Check
        rm -rf face.db
    else
        if [ "${test_whate}" = "test_FaceID" ]; then
            echo "FaceID : register"
            ./test/samples_for_test/bin/${test_whate} 0 ${video_path} 25 ./face.db ./ 5
            Check
            echo "FaceID : login"
            ./test/samples_for_test/bin/${test_whate} 1 ${video_path} 25 ./face.db ./ 5
            Check
        else
            ./test/samples_for_test/bin/${test_whate} ${video_path} 25
            Check
        fi
    fi
}

Sample_For_Test()
{
    number=0
    cd ${vehicle_path}
    tar -zxvf ${tar_package}
    echo "Run samples_for_test..."
    cd ${package}
    source ./samples/tools/env.sh product ${vehicle}
    source ./samples/tools/env.sh samples
    while :
    do
        if [ ${count} = "-1" ] ;then
            Run
            sleep 0.5
            continue
        else
            Run
            if [ ${number} = ${count} ] ;then
                break
            else
                echo "count = ${number}"
                let number+=1
                sleep 0.5
                continue
            fi
        fi
    done
}

Resource_Test()
{
    cd ${vehicle_path}
    tar -zxvf ${tar_package}
    echo "Run samples_for_test..."
    cp execute.sh ${package}
    cd ${package}
    source ./samples/tools/env.sh product ${vehicle}
    source ./samples/tools/env.sh samples
    if [ "${test_whate}" = "test_all" ]; then
        cp ${vehicle}/data/config/* test/resource_test/config_drive/
        ./test/resource_test/bin/test_ResourceTest test/resource_test/config_drive/config.json >> drive.txt
        Check
        source ./execute.sh silver ./test/resource_test/bin/test_ResourceTest test/resource_test/config_drive/config.json >> drive_sliver.txt
        Check
        sleep 0.5
        cp ${vehicle}/data/config/* test/resource_test/config_faceid/
        ./test/resource_test/bin/test_ResourceTest test/resource_test/config_faceid/config.json >> faceid.txt
        Check
        source ./execute.sh silver ./test/resource_test/bin/test_ResourceTest test/resource_test/config_faceid/config.json >> faceid_silver.txt
        Check
    else
        cp ${vehicle}/data/config/* test/resource_test/config_${test_whate}
        ./test/resource_test/bin/test_ResourceTest test/resource_test/config_${test_whate}/config.json >> ${test_whate}.txt
        Check
        source ./execute.sh silver ./test/resource_test/bin/test_ResourceTest test/resource_test/config_${test_whate}/config.json >> ${test_whate}_silver.txt
        Check
    fi    
}


if [ $# -lt 4 ]; then
    echo  $* 
    echo -e "\
Usage: \n\
    $0 <vehicle_path> <package> <vehicle> <test_whate[test_all、test_FaceID...]> \n\
    $0 <vehicle_path> <package> <vehicle> <test_whate[test_all、test_FaceID...]> <video_path> <count>"
    exit 1
fi

if [ $# -eq 4 ]; then
    vehicle_path=$1
    package=$2
    vehicle=$3
    test_whate=$4
    tar_package=$package.tar.gz
    if [ `echo $tar_package | grep -c "DMS" ` -gt 0 ]; then
        Tmp_type="DMS"
    elif [ `echo $tar_package | grep -c "OMS" ` -gt 0 ] ;then
        Tmp_type="OMS"
    else
        echo "Don't know OMS or DMS ..."
    fi
    echo "Tmp_type = ${Tmp_type}"
    echo "$#"
    Resource_Test
elif [ $# -eq 6 ]; then
    vehicle_path=$1
    package=$2
    vehicle=$3
    test_whate=$4
    tar_package=$package.tar.gz
    video_path=$5
    count=$6
    if [ `echo $tar_package | grep -c "DMS" ` -gt 0 ]; then
        Tmp_type="DMS"
    elif [ `echo $tar_package | grep -c "OMS" ` -gt 0 ] ;then
        Tmp_type="OMS"
    else
        echo "Don't know OMS or DMS ..."
    fi
    echo "Tmp_type = ${Tmp_type}"
    echo "$#"
    Sample_For_Test
else
    echo "Unknown"
    exit 1
fi


