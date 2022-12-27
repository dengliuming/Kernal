echo `export ARCH=arm`
echo `export CROSS_COMPILE=arm-buildroot-linux-gnueabihf-`
echo `export PATH=$PATH:/home/book/share/IMX6ULL_Pro/100ask_imx6ull-sdk/IMX/ToolChain/arm-buildroot-linux-gnueabihf_sdk-buildroot/bin`
if [ $# = 0 ];then
    echo "没有带参数";
    echo `make`
    echo `ls`
elif [ "$1" = "clean" ];then
    echo "带了$#个参数 : $1"
    echo `make $1`
    echo `ls`
fi