#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/delay.h>
#include <linux/poll.h>
#include <linux/mutex.h>
#include <linux/wait.h>
#include <linux/uaccess.h>
#include <linux/device.h>
#include <asm/io.h>

static int major = 0;
static struct class *cls;
/* 使能GPIO的寄存器地址 0x02290000 + 0x14 */
static volatile unsigned int* IOMUXC_SNVS_SW_MUX_CTL_PAD_SNVS_TAMPER3;
/* 设置GPIO5_3引脚为输出引脚 0x020AC004 */
static volatile unsigned int* GPIO5_GDIR;
/* 设置GPIO5_3引脚为输出的高低电平 0x020AC000 */
static volatile unsigned int* GPIO5_DR;

static int led_open (struct inode *node, struct file *fd)
{
    /* enable gpio5 初始化时已经使能
	 * configure gpio5_io3 as gpio
	 * configure gpio5_io3 as output 
	 */
    // configure gpio5_io3 as gpio
    *IOMUXC_SNVS_SW_MUX_CTL_PAD_SNVS_TAMPER3 &= ~0xf;    //清空寄存器后四位的值
    *IOMUXC_SNVS_SW_MUX_CTL_PAD_SNVS_TAMPER3 |= 0x05;    //后四位写：0101 
    // configure gpio5_io3 as output 
    *GPIO5_GDIR |= (1<<3);  //将bit3变成1

    printk("%s %s %d \n",__FILE__,__FUNCTION__,__LINE__);  
    return 0;
}
static ssize_t led_write (struct file *fd, const char __user *buf, size_t length, loff_t *ppos)
{
    char val;
    int ret;
    printk("%s %s %d \n",__FILE__,__FUNCTION__,__LINE__);  
    ret = copy_from_user (&val, buf, 1);
    if(ret < 0)
    {
        printk("write error: %s\n", buf);
        return -1;
    }
    printk(" write result: %d\n", val);
    if(val)
    {
        /* open led */
        *GPIO5_DR &= ~(1<<3);   //让bit3 = 0
    }
    else
    {
        /* close led */
        *GPIO5_DR |= (1<<3);   //让bit3 = 1
    }
    return 1;
}
static struct file_operations led_op= {
    .owner = THIS_MODULE,
    .open = led_open,
    .write = led_write,
};



//初始化入口函数
static int __init led_init(void)
{
    printk("%s %s %d \n",__FILE__,__FUNCTION__,__LINE__);   
    //注册字符设备
    major = register_chrdev(major, "imx611_led",&led_op);    //注册字符设备名称
    if (major < 0)
    {
        printk("  register_chrdev faile \n");
        return -1;
    }
    //创建设备节点
    cls = class_create(THIS_MODULE, "myled");               //模块名称
    device_create(cls, NULL,MKDEV(major,0),"myled",NULL);       //设备名称  /* 创建设备节点：/dev/myled */

    /* ioremap ：将物理地址映射成虚拟地址(地址 地址所占空间) */
    // IOMUXC_SNVS_SW_MUX_CTL_PAD_SNVS_TAMPER3 地址：0x02290000 + 0x14
	IOMUXC_SNVS_SW_MUX_CTL_PAD_SNVS_TAMPER3 = ioremap(0x02290000 + 0x14, 4);
	
	// GPIO5_GDIR 地址：0x020AC004
	GPIO5_GDIR = ioremap(0x020AC004, 4);
	
	//GPIO5_DR 地址：0x020AC000
	GPIO5_DR  = ioremap(0x020AC000, 4);

    return 0;
}
static void __exit led_exit(void)
{
    iounmap(IOMUXC_SNVS_SW_MUX_CTL_PAD_SNVS_TAMPER3);
    iounmap(GPIO5_GDIR);
    iounmap(GPIO5_DR);
    device_destroy(cls,MKDEV(major,0));
    class_destroy(cls);
    unregister_chrdev(major,"led_1");
}
module_init(led_init);
module_exit(led_exit);
MODULE_LICENSE("GPL");

