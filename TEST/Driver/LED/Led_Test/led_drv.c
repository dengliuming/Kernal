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
#include <linux/types.h>
#include <linux/string.h>
#include <linux/module.h>
#include <asm/io.h>
#include "include/Led_resource.h"



static struct gpio_resource* g_gpio_re;
static int major;
static struct class* g_led_class;

static int G_LedDrvOpen (struct inode *node, struct file *fi)
{
    int num = iminor(node);
    g_gpio_re->init(num);
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
	return 0;
}
ssize_t G_LedDrvWrite (struct file *fi, const char __user *buf, size_t size, loff_t *lof)
{
    struct inode *node = file_inode(fi);
    int num = iminor(node);
    char status;
    int err;
    err = copy_from_user(&status, buf, 1);
    g_gpio_re->ctl(num,status);

	return size;
}


static struct file_operations g_led_file_operation = {
    .owner = THIS_MODULE,
	.open = G_LedDrvOpen,
	.write = G_LedDrvWrite,
};

static int __init G_LedFileOperationInit(void)
{
    major = register_chrdev(0,"led_chrdev",&g_led_file_operation);
    g_led_class = class_create(THIS_MODULE,"led_class");
    if(IS_ERR(g_led_class))
    {
        printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
		unregister_chrdev(major, "led_chrdev");
		return -1;
    }
    return 0;
}
static void __exit G_LedFileOperationExit(void) 
{
    class_destroy(g_led_class);
    unregister_chrdev(major,"led_chrdev");
}


/* API接口 */
// 次设备号注册
void G_RegesterLedOperation(int mior)
{
    device_create(g_led_class,NULL,MKDEV(major,mior),NULL,"led_%d",mior);
}
// 销毁次设备号
void G_DestroyLedOperation(int mior)
{
    device_destroy(g_led_class,MKDEV(major,mior));
}
void G_GetGpioResourcePtr(struct gpio_resource *gpio_re)
{
    g_gpio_re = gpio_re;
}
EXPORT_SYMBOL(G_RegesterLedOperation);
EXPORT_SYMBOL(G_DestroyLedOperation);
EXPORT_SYMBOL(G_GetGpioResourcePtr);


module_init(G_LedFileOperationInit);
module_exit(G_LedFileOperationExit);

MODULE_LICENSE("GPL");

