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

#include "include/led_driver.h"
#include "include/led_drv.h"
#include"include/Led_resource.h"

static int g_num = 0;
static int g_add_gpio[100];
int G_LedProbe(struct platform_device *dev)	//初始化驱动
{
    struct resource* res;
	int i = 0;
    while(1)
    {
        res = platform_get_resource(dev,IORESOURCE_REG,i);
		if(!res)
		{
			break;
		}
		g_add_gpio[i] = res->start;
		/* 主设备号注册 */
		G_RegesterLedOperation(i);
		i++;
    }
	g_num = i;
	return 0;
}
int G_LedRemove(struct platform_device *dev)
{
	int i;
	for(i = 0; i < g_num; i++)
	{
		G_DestroyLedOperation(i);
	}
	return 0;
}

/* Led Resource */
int G_LedInit (int whitch)
{
    /* 初始化引脚 */
    printk(" Init gpio : group = %d ,pin = %d \n",GROUP(g_add_gpio[whitch]),PIN(g_add_gpio[whitch]));
    switch(GROUP(g_add_gpio[whitch]))
    {
        case 0:
            printk("Init pin of group 0 ... \n");
        break;
        case 1:
            printk("Init pin of group 1 ... \n");
        break;
        case 2:
            printk("Init pin of group 2 ... \n");
        break;
        case 3:
            printk("Init pin of group 3 ... \n");
        break;
    }
    return 0;
}
int G_LedCtl(int whitch,char status)
{
    /* 控制指定引脚 */
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    switch(GROUP(g_add_gpio[whitch]))
    {
        case 0:
            printk("Ctl pin of group 0 ... \n");
        break;
        case 1:
            printk("Ctl pin of group 1 ... \n");
        break;
        case 2:
            printk("Ctl pin of group 2 ... \n");
        break;
        case 3:
            printk("Ctl pin of group 3 ... \n");
        break;
    }
    return 0;
}

static struct gpio_resource g_LedResource = {
    .init = G_LedInit,
    .ctl  = G_LedCtl,
};

static struct platform_driver g_led_driver = {
	.probe = G_LedProbe,
	.remove = G_LedRemove,
	.driver = {
		.name = "led_test",
	}
};
/* Led Resource */
static int G_LedPlatformDriverInit(void)
{
    int err;
    err = platform_driver_register(&g_led_driver);
    if(err < 0)
    {
        printk(" Fail  platform_driver_register \n");
		return -1;
    }
	G_GetGpioResourcePtr(&g_LedResource);
	return 0;
}

static void G_LedDriverExit(void)	//出口函数
{
	platform_driver_unregister(&g_led_driver);
}






module_init(G_LedPlatformDriverInit);		//注册入口函数
module_exit(G_LedDriverExit);		//注册出口函数
MODULE_LICENSE("GPL");



