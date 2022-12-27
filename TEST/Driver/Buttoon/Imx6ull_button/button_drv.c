#include <linux/module.h>
#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/major.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/fcntl.h>
#include <linux/fs.h>
#include <linux/signal.h>
#include <linux/mutex.h>
#include <linux/mm.h>
#include <linux/timer.h>
#include <linux/wait.h>
#include <linux/skbuff.h>
#include <linux/proc_fs.h>
#include <linux/poll.h>
#include <linux/capi.h>
#include <linux/kernelcapi.h>
#include <linux/init.h>
#include <linux/device.h>
#include <linux/moduleparam.h>

#include "include/board_100ask_imx6ull.h"

struct Button_Imx6ull* btn;
int minor = 0;
static int major = 0;
static struct class *button_class;

static int Open (struct inode *node, struct file *file) {
    minor = iminor(node);	//获取次设备号
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    btn->init(minor);
    return 0;
}

static ssize_t Read (struct file *file, char __user *buf, size_t size, loff_t *offset)
{
    char* buff;
	printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    btn->read(minor,buff,size);
    copy_to_user(buf,&buff,sizeof(buff));
	return sizeof(buff);
}

static ssize_t Write (struct file *file, const char __user *buf, size_t size, loff_t *offset) {
    struct inode *node = file_inode(file);
    minor = iminor(node);
    char* buff;
    if (copy_from_user(&buff,buf,1) < 0) {
        printk(" Error  copy_from_user \n");
		return -1;
    }
    btn->write(minor,buff,sizeof(char));
    return size;
}

static struct file_operations btn_file = {
    .open = Open,
    .read = Read,
    .write = Write
};

void RegestButtonImx6ll(struct Button_Imx6ull* ptr) {
    int i;

	btn = ptr;
	for (i = 0; i < ptr->count; i++)
	{
		device_create(button_class, NULL, MKDEV(major, i), NULL, "100ask_button%d", i);
	}
}

void UnregestButtonImx6ll(struct Button_Imx6ull* ptr) {
    int i;

	for (i = 0; i < ptr->count; i++)
	{
		device_destroy(button_class, MKDEV(major, i));
	}
}

EXPORT_SYMBOL(RegestButtonImx6ll);
EXPORT_SYMBOL(UnregestButtonImx6ll);

int button_init(void)
{
	major = register_chrdev(0, "100ask_button", &btn_file);

	button_class = class_create(THIS_MODULE, "100ask_button");
	if (IS_ERR(button_class))
		return -1;
	
	return 0;
}

void button_exit(void)
{
	class_destroy(button_class);
	unregister_chrdev(major, "100ask_button");
}

module_init(button_init);
module_exit(button_exit);
MODULE_LICENSE("GPL");

