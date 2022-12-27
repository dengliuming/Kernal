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

#include"include/led_operation.h"
#include "include/led_resource.h"
#include "include/led_drv.h"


static int sg_LedPin[100];
static int sg_LedCnt = 0;


int Bord_Demo_init(int whitch)
{
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    printk("init gpio:group = %d, pin = %d \n",GROUP(sg_LedPin[whitch]), PIN(sg_LedPin[whitch]));
    switch(GROUP(sg_LedPin[whitch]))
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
int Bord_Demo_Ctl(int whitch,char status)
{
    /* 控制指定引脚 */
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    switch(GROUP(sg_LedPin[whitch]))
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


static struct led_operations g_led_op = {
    .number = 1,
    .init   = Bord_Demo_init,
    .ctl    = Bord_Demo_Ctl,
};



static int SG_LedDriverProbe(struct platform_device *dev)
{
	unsigned int i = 0;
	struct resource* res;
	while(1)
	{
		/* 记录引脚 */
		res = platform_get_resource(dev, IORESOURCE_REG, i++);	//获取设备dev的第i个资源，资源类型为中断
		if(!res)
		{
			break;
		}
		sg_LedPin[sg_LedCnt] = res->start;  //获取GOIO设置的地址
		/* device_create 在此使用的是led_drv.c提供的API接口*/
		G_LedDevicesCreate(sg_LedCnt++);
	}
	

	
	return 0;
}
static int SG_LedDriverRemote(struct platform_device *dev)
{	
	/* device_destroy */
	int i;
	for(i = 0; i < sg_LedCnt; i++)
	{
		G_LedDevicesDestroy(i);
	}
	sg_LedCnt = 0;
	return 0;
}


static struct platform_driver SG_ChipDemoGpioDrive = {
	.probe = SG_LedDriverProbe,
	.remove = SG_LedDriverRemote,
	.driver = {
		.name = "board_A",
	},
};
static int SG_LedDriverInit(void) //入口函数
{
	int err;
	err = platform_driver_register(&SG_ChipDemoGpioDrive);
	if(err < 0)
	{
		printk(" Fail  platform_device_register \n");
		return -1;
	}
	G_RegesterLedOperation(&g_led_op);
	return 0;
}
static void SG_LedDriverExit(void)	//出口函数
{
	platform_driver_unregister(&SG_ChipDemoGpioDrive);
}

module_init(SG_LedDriverInit);		//注册入口函数
module_exit(SG_LedDriverExit);		//注册出口函数
MODULE_LICENSE("GPL");


