#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
/*
 * ./button_app /dev/100ask_button0 
 */

int main(int argc,char** argv) {
    if (argc < 3) {
        printf("Usage: %s <dev> <1 / 0>\n",argv[0]);
        return -1;
    }
    if ( "1" == argv[2] | "0" == argv[2]) {
        printf(" Please inpute <1 / 0> \n");
        return -1;
    }
    int fd = open(argv[1],O_RDWR);
    if (0 > fd) {
        printf(" Open %s file \n", argv[1]);
        return -1;
    }
    char val = argv[2];
    write(fd,&val,sizeof(val));
    read(fd,&val,sizeof(val));

    printf(" val = %s \n",val);

    close(fd);
    return 0;
}
