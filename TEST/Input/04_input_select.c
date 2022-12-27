/* POLL机制 ；定时超时唤醒 */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <linux/input.h>
#include <string.h>
#include <unistd.h>
#include <sys/select.h>
/* According to earlier standards */
#include <sys/time.h>


/* ./01_input /dev/input/event0  非阻塞方式查询读取数据*/
int main(int argc, char **argv){
    int fd;
    struct input_event event;
    fd_set read_fdset;
    struct timeval timeout;
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
        /* 设置超时时间 */
		timeout.tv_sec  = 5;
		timeout.tv_usec = 0;
        /* 想监测哪些文件? */
		FD_ZERO(&read_fdset);    /* 先全部清零 */	
		FD_SET(fd, &read_fdset); /* 想监测fd */
        /* 函数原型为:
			int select(int nfds, fd_set *readfds, fd_set *writefds,
                  fd_set *exceptfds, struct timeval *timeout);
         * 我们为了"read"而监测, 所以只需要提供readfds
		 */
        int nfds = fd + 1;/* nfds 是最大的文件句柄+1, 注意: 不是文件个数, 这与poll不一样 */ 
        int len = select(nfds,&read_fdset,NULL,NULL,&timeout);
        if (len > 0)  /* 有文件可以提供数据了 */
		{
			/* 再次确认fd有数据 */
			if (FD_ISSET(fd, &read_fdset))
			{
				while (read(fd, &event, sizeof(event)) == sizeof(event))
				{
					printf("get event: type = 0x%x, code = 0x%x, value = 0x%x\n", event.type, event.code, event.value);
				}
			}
		}
		else if (len == 0)  /* 超时 */
		{
			printf("time out\n");
		}
		else   /* -1: error */
		{
			printf("select err\n");
		}
    }


    return 0;
}

