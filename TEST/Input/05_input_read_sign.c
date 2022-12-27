/* 异步通讯 */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <linux/input.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
int g_fd;
void MySigHandel(int sig){  //接收到信号时：信号处理函数
    struct input_event event;
    while(read(g_fd, &event, sizeof(struct input_event) == sizeof(struct input_event))){
        printf("type  = 0x%x \n",event.type );
	    printf("code  = 0x%x \n",event.code );
	    printf("value = 0x%x \n",event.value);
    }
}
/* ./05_input_read_sign /dev/input/event0  非阻塞方式查询读取数据*/
int main(int argc, char **argv){
    struct input_event event;
    if(argc != 2){
        printf("Usage: ./01_input   <input file name> \n");
        return -1;
    }
    /* 注册信号处理函数 */
    signal(SIGIO, MySigHandel);
    /* 打开驱动程序 */
    g_fd = open(argv[1],O_RDWR | O_NONBLOCK); //非阻塞方式打开文件，不进入休眠状态，避免poll关闭
    if(g_fd < 0){
        printf("Error opening input file: %s\n", argv[1]);
        return -1;
    }
    struct input_id id;
    int err = ioctl (g_fd, EVIOCGID, &id);    //获取输入设备的ID数据
    if(err == 0){
        printf("bustype = 0x%x \n",id.bustype);
	    printf("vendor  = 0x%x \n",id.vendor);
	    printf("product = 0x%x \n",id.product);
	    printf("version = 0x%x \n",id.version);
    }
    unsigned int evbit[2];
    int len = ioctl(g_fd,EVIOCGBIT(0,sizeof(evbit)),&evbit);   //读取两个字节
    printf(" len = %d\n", len);
    if(len > 0 && len < sizeof(evbit)){
        printf(" evbit[%d] = %d\n", evbit[0], evbit[1]);
    }
    /* 把APP进程ID告诉给驱动程序 */
    fcntl(g_fd, F_SETOWN,getpid());  
    /* 使能“异步通知” */
    int Flag = fcntl(g_fd,F_GETFL);
    fcntl(g_fd,F_SETFL,Flag|FASYNC);
    int count = 0;
    while(1){
        printf("man loop count: %d\n",count++);
        sleep(2);
    }


    return 0;
}

