#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <linux/input.h>

/* ./01_input /dev/input/event0 */
int main(int argc, char **argv){
    if(argc < 2){
        printf("Usage: ./01_input   <input file name>\n");
        return -1;
    }
    int fd = open(argv[1], O_RDWR);
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
    return 0;
}

