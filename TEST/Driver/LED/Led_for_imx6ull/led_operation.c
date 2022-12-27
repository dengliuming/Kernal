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
#include<asm/io.h>

static volatile unsigned int *gptr_CCM_CCGR1;
static volatile unsigned int *gptr_GPIO5_Enable;
static volatile unsigned int *gptr_GPIO5_SetOutput;
static volatile unsigned int *gptr_GPIO5_DR;

int Bord_Demo_init(int whitch)
{
    if(!gptr_CCM_CCGR1 && whitch == 0) //判断是否为空指针
    {
        /* 使能GPIO引脚 */
        gptr_CCM_CCGR1 = ioremap(0x20c406c,4);
        *gptr_CCM_CCGR1 |= (3 << 30);     //设置为bit[31,30]=11
        /* 设置指定引脚为gpio引脚 */
        gptr_GPIO5_Enable = ioremap(0x2290014,4);   //设置为bit[3,0]=0101
        *gptr_GPIO5_Enable &= ~(0xF << 0);   //清0
        *gptr_GPIO5_Enable |= (5 << 0);
        /* 设置某引脚为输出引脚 */
        gptr_GPIO5_SetOutput = ioremap(0x020AC000 + 0X4, 4);    //设置为bit[3] = 1
        *gptr_GPIO5_SetOutput |= (1 << 3);
        /* 高电平 */
        gptr_GPIO5_DR = ioremap(0x020A000 + 0, 4);
    }
    

    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    return 0;
}
int Bord_Demo_Ctl(int whitch,char status)
{
    /* 控制指定引脚 */
    printk("%s %s line %d\n", __FILE__, __FUNCTION__, __LINE__);
    if(whitch == 0)
    {
        if(!status)  //1
        {
            *gptr_GPIO5_DR |= (1 << 3);
        }
        else
        {
            *gptr_GPIO5_DR &= ~(1 << 3);
        }
    }
    return 0;
}
void Bord_Demo_End(void)
{
    iounmap(gptr_CCM_CCGR1);
    iounmap(gptr_GPIO5_Enable);
    iounmap(gptr_GPIO5_SetOutput);
    iounmap(gptr_GPIO5_DR);
}

static struct led_operations g_led_op = {
    .number = 1,
    .init   = Bord_Demo_init,
    .ctl    = Bord_Demo_Ctl,
    .end    = Bord_Demo_End,
};
struct led_operations *GetBordLedOperations(void)
{
    return &g_led_op;
}

