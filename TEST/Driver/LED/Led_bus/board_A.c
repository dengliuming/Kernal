
#include <linux/module.h>

#include <linux/fs.h>
#include <linux/errno.h>
#include <linux/miscdevice.h>
#include <linux/kernel.h>
#include <linux/major.h>
#include <linux/mutex.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/stat.h>
#include <linux/init.h>
#include <linux/device.h>
#include <linux/tty.h>
#include <linux/kmod.h>
#include <linux/gfp.h>
#include <linux/platform_device.h>
#include "include/led_resource.h"

static struct file_resource g_led_source = {
    .pin = GPIO_PIN(3,1),         //GPIO3_0
};
struct file_resource* Get_file_resource(void)
{
    return &g_led_source;
}

static struct resource SG_BoardALedDevResource[] = {
    {
		.start = GPIO_PIN(3,1),			//起始地址
		.flags = IORESOURCE_REG,		//资源类型	- 中断
	},
	{
		.start = GPIO_PIN(5,8),			//起始地址
		.flags = IORESOURCE_REG,		//资源类型	- 中断
	},
};
static void SG_LedDeviceRelease(struct device *dev)
{
}


static struct platform_device SG_BoardALedDev = {
	.name = "board_A",										//device 的名称
	.num_resources = ARRAY_SIZE(SG_BoardALedDevResource),	//资源大小
	.resource = SG_BoardALedDevResource,					//资源
	.dev = {
		.release  = SG_LedDeviceRelease,
	},
};


static int LedDevInit(void)	//入口函数
{
	int err;
	err = platform_device_register(&SG_BoardALedDev);
	if(err < 0)
	{
		printk(" Fail  platform_device_register \n");
		return -1;
	}
	return 0;
}
static void LedDevExit(void)	//出口函数
{
	platform_device_unregister(&SG_BoardALedDev);
}

module_init(LedDevInit);
module_exit(LedDevExit);
MODULE_LICENSE("GPL");




