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
#include"led_operation.h"


int Bord_Demo_init(int whitch)
{
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    return 0;
}
int Bord_Demo_Ctl(int whitch,char status)
{
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    return 0;
}

static struct led_operations g_led_op = {
    .init = Bord_Demo_init,
    .ctl = Bord_Demo_Ctl,
};
struct led_operations *GetBordLedOperations(void)
{
    return &g_led_op;
}

