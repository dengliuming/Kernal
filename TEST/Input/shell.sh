echo `export ARCH=arm`
echo `export CROSS_COMPILE=arm-buildroot-linux-gnueabihf-`
echo `export PATH=$PATH:/home/book/share/IMX6ULL_Pro/100ask_imx6ull-sdk/IMX/ToolChain/arm-buildroot-linux-gnueabihf_sdk-buildroot/bin`
echo ">>>>>>>>>>>>>>>>>>> 开始交叉编译环境配置 <<<<<<<<<<<<<<<<<<<<<<<<<<"
echo "export ARCH=arm"
echo "export CROSS_COMPILE=arm-buildroot-linux-gnueabihf-"
echo "export PATH=$PATH:/home/book/share/IMX6ULL_Pro/100ask_imx6ull-sdk/IMX/ToolChain/arm-buildroot-linux-gnueabihf_sdk-buildroot/bin"
echo ">>>>>>>>>>>>>>>>>>> 交叉编译环境配置完成 <<<<<<<<<<<<<<<<<<<<<<<<<<"
if [ $# == 0 ];then
    echo "没有带参数";
    echo `make`
    echo `ls`
else
    echo "带了$#个参数 : $1"
    echo `make $1`
    echo `ls`
fi
