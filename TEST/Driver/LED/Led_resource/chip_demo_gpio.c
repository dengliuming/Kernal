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
#include<asm/io.h>

#include"include/led_operation.h"
#include "include/led_resource.h"


static struct file_resource* g_led_res;
int Bord_Demo_init(int whitch)
{
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    if(!g_led_res)
    {
        g_led_res = Get_file_resource();
    }
    printk("init gpio:group = %d, pin = %d \n",GROUP(g_led_res->pin), PIN(g_led_res->pin));
    switch(GROUP(g_led_res->pin))
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
    switch(GROUP(g_led_res->pin))
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


static struct led_operations g_led_op = {
    .number = 1,
    .init   = Bord_Demo_init,
    .ctl    = Bord_Demo_Ctl,
};
struct led_operations *GetBordLedOperations(void)
{
    return &g_led_op;
}

