/* POLL机制 ；定时超时唤醒 */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <linux/input.h>
#include <string.h>
#include <unistd.h>
#include <poll.h>

/* ./01_input /dev/input/event0  非阻塞方式查询读取数据*/
int main(int argc, char **argv){
    int fd;
    struct input_event event;
    struct pollfd fd_events[1];    //poll文件监测事件,检测文件1
    nfds_t nfds = 1;                //检测文件数量
    if(argc != 2){
        printf("Usage: ./01_input   <input file name> \n");
        return -1;
    }
    fd = open(argv[1],O_RDWR | O_NONBLOCK); //非阻塞方式打开文件，不进入休眠状态，避免poll关闭
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
        fd_events[0].fd = fd;
        fd_events[0].events = POLLIN;   //期望事件： 有数据输入
        fd_events[0].revents = 0;       //返回数据的事件类型
        int len2 = poll(fd_events,nfds,5000);  //5s后超时唤醒
        if(len2 < 0){
            printf("Error polling nfds_t file for events %d\n",nfds);
        }
        if(len2 > 0){    //有数据且是在5s时间内发生
            if(fd_events[0].revents == POLLIN) {
                while(read(fd, &event, sizeof(event)) == sizeof(event)) {   //循环读
                    printf("type  = 0x%x \n",event.type );
	                printf("code  = 0x%x \n",event.code );
	                printf("value = 0x%x \n",event.value);
                }
            }   
        }
        else if(len2 == 0) {
            printf("timed out\n");
        }
    }


    return 0;
}

