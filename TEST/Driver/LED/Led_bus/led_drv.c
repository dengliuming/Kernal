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
#include "include/led_operation.h"
#include <linux/types.h>
#include <linux/string.h>
#include <linux/module.h>
#include <asm/io.h>



/* 1. 确定主设备号                                                                 */
static int major = 0;
static struct class *led_class;
static struct led_operations* gptr_led_op;

#define MIN(a, b) (a < b ? a : b)


/* 3. 实现对应的open/read/write等函数，填入file_operations结构体                   */
static ssize_t led_drv_read (struct file *file, char __user *buf, size_t size, loff_t *offset)
{
	printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
	return 0;
}
/* write(fd,&val,1) */
static ssize_t led_drv_write (struct file *file, const char __user *buf, size_t size, loff_t *offset)
{
	int err;
	char status;
	struct inode *node = file_inode(file);
	int minor = iminor(node);	//获取次设备号
	printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
	err = copy_from_user(&status,buf,1);
	if(err < 0)
	{
		printk(" Error  copy_from_user \n");
		return -1;
	}
	/* 根据次设备号和status控制设备 */
	gptr_led_op->ctl(minor,status);
	return 1;
}

static int led_drv_open (struct inode *node, struct file *file)
{
	int minor = iminor(node);	//获取次设备号
	printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
	/* 根据次设备号初始化LED */
	gptr_led_op->init(minor);
	return 0;
}

static int led_drv_close (struct inode *node, struct file *file)
{
	printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
	return 0;
}

/* 2. 定义自己的file_operations结构体                                              */
static struct file_operations led_drv = {
	.owner	 = THIS_MODULE,
	.open    = led_drv_open,
	.read    = led_drv_read,
	.write   = led_drv_write,
	.release = led_drv_close,
};

/* 4. 把file_operations结构体告诉内核：注册驱动程序                                */
/* 5. 谁来注册驱动程序啊？得有一个入口函数：安装驱动程序时，就会去调用这个入口函数 */
static int __init led_init(void)
{
	int err;
	printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
	major = register_chrdev(0, "led_A", &led_drv);  	// 注册字符设备 主设备号


	led_class = class_create(THIS_MODULE, "led_A_class");	
	err = PTR_ERR(led_class);
	if (IS_ERR(led_class)) {
		printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
		unregister_chrdev(major, "led_A");
		return -1;
	}

	
	return 0;
}

void G_LedDevicesCreate(int minor)	//主设备号创建的函数接口
{
	device_create(led_class, NULL, MKDEV(major, minor), NULL, "led_A_%d", minor); /* /dev/led_A */	// 创建设备节点
}
void G_LedDevicesDestroy(int minor)	//主设备号创建的函数接口
{
	device_destroy(led_class, MKDEV(major, minor));
}
void G_RegesterLedOperation(struct led_operations *opr)	//底层提供led_operations地址
{
	gptr_led_op = opr;
}

EXPORT_SYMBOL(G_LedDevicesCreate);	//将这个API函数接口导出，让别的驱动程序使用这个API接口
EXPORT_SYMBOL(G_LedDevicesDestroy);	//将这个API函数接口导出，让别的驱动程序使用这个API接口
EXPORT_SYMBOL(G_RegesterLedOperation);	//将这个API函数接口导出，让别的驱动程序使用这个API接口



/* 6. 有入口函数就应该有出口函数：卸载驱动程序时，就会去调用这个出口函数           */
static void __exit led_exit(void)
{
	printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
	class_destroy(led_class);
	unregister_chrdev(major, "led_A");
}



/* 7. 其他完善：提供设备信息，自动创建设备节点                                     */

module_init(led_init);
module_exit(led_exit);

MODULE_LICENSE("GPL");


