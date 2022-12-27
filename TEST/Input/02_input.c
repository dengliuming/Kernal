#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <linux/input.h>
#include <string.h>
#include <unistd.h>

/* ./01_input /dev/input/event0 noblock 非阻塞方式查询读取数据*/
int main(int argc, char **argv){
    int fd;
    struct input_event event;
    if(argc < 2){
        printf("Usage: ./01_input   <input file name> [noblock]\n");
        return -1;
    }
    if(argc == 3 && !strcmp(argv[1], "noblock")) {
        fd = open(argv[1], O_RDWR | O_NONBLOCK);    //非阻塞方式 ： 不会进入休眠(查询方式)
    }
    else{
        fd = open(argv[1],O_RDWR);                  //阻塞方式 ： 会进入休眠(休眠-唤醒方式)
    }
    if(fd < 0){
        printf("Error opening input file: %s\n", argv[1]);
        return -1;
    }
    struct input_id id;
    int err = ioctl (fd, EVIOCGID, &id);    //获取输入设备的ID数据
    if(err == 0){
        printf("bustype = 0x%x \n",id.bustype);
	    printf("vendor  = 0x%x \n",id.vendor);
	    printf("product = 0x%x \n",id.product);
	    printf("version = 0x%x \n",id.version);
    }
    unsigned int evbit[2];
    int len = ioctl(fd,EVIOCGBIT(0,sizeof(evbit)),&evbit);   //读取两个字节
    printf(" len = %d\n", len);
    if(len > 0 && len < sizeof(evbit)){
        printf(" evbit[%d] = %d\n", evbit[0], evbit[1]);
    }
    while(1){
        len = read(fd, &event, sizeof(event));
        if(len == sizeof(event)){
            printf("type  = 0x%x \n",event.type );
	        printf("code  = 0x%x \n",event.code );
	        printf("value = 0x%x \n",event.value);
        }
        else{
            printf("read error %d\n",len);
        }
    }


    return 0;
}

