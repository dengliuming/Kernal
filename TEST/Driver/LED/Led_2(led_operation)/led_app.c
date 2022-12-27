
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

/*
 * ./hello_drv_test -w abc
 * ./hello_drv_test -r
 */
int main(int argc, char **argv)
{
	int fd;
	char status;
	int len = 1;
	
	/* 1. 判断参数 */
	if (argc != 3) 
	{
		printf("Usage: %s <dev> <on/off> \n", argv[0]);
		return -1;
	}

	/* 2. 打开文件 */
	fd = open(argv[1], O_RDWR);
	if (fd == -1)
	{
		printf("can not open file /dev/hello\n");
		return -1;
	}

	/* 3. 写文件或读文件 */
	if (0 == strcmp(argv[2], "on")
	{
		status = 1;
	}
	else if (0 == strcmp(argv[2], "off")
	{
		status = 0;
	}
	write(fd, &status, len);
	close(fd);
	
	return 0;
}


