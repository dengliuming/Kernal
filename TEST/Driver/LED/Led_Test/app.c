#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

/* app /dev/led_0 off/on */
int main(int argc,char **argv)
{
    if(argc != 3)
    {
        printf(" Usag: %s <dev/led> <foo/on> \n",argv[0]);
        return -1;
    }
    int fd;
    char status;
    fd = open(argv[1],O_RDWR);
    if(fd < 0)
    {
        printf(" open fail %s \n",argv[0]);
        return -1;
    }
    if(0 == strcmp(argv[2],"off"))
    {
        status = 0;
        write(fd,&status,1);
    }
    else if(0 == strcmp(argv[2],"on"))
    {
        status = 1;
        write(fd,&status,1);
    }
    else
    {
        printf(" Please write off/on \n");
    }
    close(fd);
    return  0;
}

