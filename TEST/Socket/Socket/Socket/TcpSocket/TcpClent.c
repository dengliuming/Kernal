#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>
#include <stdio.h>
#include <arpa/inet.h>
#include <strings.h>
#include <netinet/in.h>
#include <unistd.h>
#include <string.h>

/*
 * socket
 * connect
 * send/recv
*/
#define POINT       8885
#define MAX         1000
int main(int argc,char** argv)
{
    int iSocketClient;
    int err,lenght;

    struct sockaddr_in addr;
    unsigned char uClientBuff[MAX];
    unsigned char uServerBuff[MAX];
    if (argc != 2)
    {
        printf(" Err: Please: %s <cliend address> \n",argv[0]);
        return -1;
    }
    
    iSocketClient = socket(AF_INET, SOCK_STREAM, 0);
    if(iSocketClient < 0)
    {
        printf(" Err socket... \n");
        return -1;
    }
    memset(&addr,0,sizeof(addr));
    addr.sin_family = AF_INET;
    if(inet_aton(argv[1],&addr.sin_addr) == 0)
    {
        printf(" Err: inet_aton... \n");
        close(iSocketClient);
        return -1;
    }
    addr.sin_port = ntohs(POINT);
    // bzero(addr.sin_zero,sizeof(addr.sin_zero));

    err = connect(iSocketClient, (const struct sockaddr *)&addr,sizeof(struct sockaddr_in));
    if (err < 0)
    {
        printf(" Err: connect... \n");
        close(iSocketClient);
        return -1;
    }
    while (1)
    {
        if(fgets(uClientBuff, MAX -1, stdin))   //从指定的流 stream 读取一行，并把它存储在 str 所指向的字符串内;stdin是标准输入，一般指键盘输入到缓冲区里的东西
        {
            err = send(iSocketClient, uClientBuff, strlen(uClientBuff), 0);
            if(err <= 0)
            {
                printf(" Err:send... \n");
                close(iSocketClient);
                return -1;
            }
        }
        uServerBuff[MAX] = '\0';
        memset(uServerBuff,0,sizeof(uServerBuff));
        lenght = recv(iSocketClient, uServerBuff, MAX - 1, 0);
        if(lenght <= 0)
        {
            printf(" ERR:recv... \n");
            close(iSocketClient);
            return -1;
        }
        else
        {
            printf(" Get Server : %s \n",uServerBuff);
        }
    }
    

    return 0;
}
