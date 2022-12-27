
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
#include "include/Led_resource.h"


static struct resource g_led_resources[] = 
{
	{
	.start = GPIO_PIN(5,1),
	.flags = IORESOURCE_REG,
	},
	{
	.start = GPIO_PIN(5,2),
	.flags = IORESOURCE_REG,
	},
};
static void G_LedDeviceRelease(struct device *dev)
{
	printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
}

static struct platform_device g_led_gpio_device = 
{
	.name = "led_test",
	.resource = g_led_resources,
	.num_resources = ARRAY_SIZE(g_led_resources),
	.dev = {
		.release = G_LedDeviceRelease
	}
};

static int G_PlatformDeviceInit(void)
{
    int err;
    err = platform_device_register(&g_led_gpio_device);
    if(err < 0)
    {
        printk(" Fail to platform_device_register \n");
        return -1;
    }
    return 0;
}
static void G_PlatformDeviceExit(void)
{
    platform_device_unregister(&g_led_gpio_device);
}
module_init(G_PlatformDeviceInit);
module_exit(G_PlatformDeviceExit);
MODULE_LICENSE("GPL");




