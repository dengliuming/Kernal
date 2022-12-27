#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>


// ledtest /dev/myled on
// ledtest /dev/myled off

int main(int argc, char **argv)
{
    int fd;
    char status = 0;
    if(argc != 3)
    {
        printf("Usage: ledtest /dev/myled on\n");
        printf("Usage: ledtest /dev/myled off\n");
        return -1;
    }
    fd = open(argv[1], O_RDWR);
    if(fd < 0)
    {
        printf  ("Error opening /dev/myled  file \n");
        return -1;
    }
    if(argv[2] == "on")
    {
        status = 1;
    }
    else if(argv[2] == "off")
    {
        status = 0;
    }
    write(fd, &status, 1);
    return 0;
}