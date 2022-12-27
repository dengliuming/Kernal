#include <sys/ioctl.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include <i2c/smbus.h>
#include <time.h>

/* ./i2cdevice <i2c_bus_number> w "100ask.taobao.com" 
*  ./i2cdevice <i2c_bus_number> r
*/
int main(int argc, char **argv)
{
    unsigned char dev_add = 0x50;
    unsigned char mem_add = 0;
    unsigned char buff[32];
    int fd,ret;
    char filename[20];
    unsigned char* str;
    struct timespec req;
    if(argc != 4 && argc != 3)
    { 
        printf("Usage:  i2cdevice <i2c_bus_number> -w data_buff  \t
                        i2cdevice <i2c_bus_number> -r \n");
        return -1;      
    }
    
    fd = open_i2c_dev(argv[1][0] - '0', filename, sizeof(filename), 0);
    if(fd < 0)
    {
        printf("Failed to open %s\n",filename);
        return -1;
    }
    if(set_slave_addr(fd, dev_add, 1))  //地址设置
    {
        printf("Failed to set slave addr\n");
        return -1;
    }
    if(argv[2][0] == 'w')
    {
        //write str:argv[3]
        req.tv_sec  = 0;
        req.tv_nsec = 20000000; //20ms
        str = argv[3];
        while(*str)
        {
            //在mem_add下写入*str
            //mem_add++,*(str++)
            ret = i2c_smbus_write_byte_data(fd,mem_add++,*(str++));
            if(ret)
            {
                printf("Failed to write mem_add \n");
                return -1;
            }
            //wait tWR 10ms
            nanosleep(&req, NULL);
        }
        ret = i2c_smbus_write_byte_data(fd,mem_add,0);    //字符串的结束符
        if(ret)
        {
            printf("Failed to write mem_add \n");
            return -1;
        }
    }
    else
    {
        ret = i2c_smbus_read_i2c_block_data(fd,mem_add,sizeof(buff),buff);
        if(ret)
        {
            printf("Failed to read mem_add \n");
            return -1;
        }
        printf("get data_buff : %s \n",buff);
    }
    return 0;
}