#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>
#include <stdio.h>
#include <arpa/inet.h>
#include <strings.h>
#include <netinet/in.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>


/*
 * socket
 * connect
 * sendto/recvfrom
*/

#define Max         1000
#define POINT       8885
#define UDP_ONE     0
int main(int argc,char* argv)
{
    if(argc != 2)
    {
        printf(" ERR: %s <Client addr> \n",&argv[0]);
        return -1;
    }

    unsigned char RecvBuff[Max];
    unsigned char RecvServerBuff[Max];
    struct sockaddr_in addr;
    int SocketClient;
    int err = 0;
    int length = 0;
    SocketClient = socket(AF_INET,SOCK_DGRAM,0);
    if(SocketClient == -1)
    {
        printf(" ERR:socket.... \n");
        return -1;
    }
    bzero(&addr,sizeof(struct sockaddr_in));
    addr.sin_family = AF_INET;
    if(inet_ntoa(addr.sin_addr) == 0)
    {
        printf(" ERR:inet_ntoa.... \n");
        close(SocketClient);
        return -1;
    }
    addr.sin_port = htons(POINT);
#if UDP_ONE
    err = connect(SocketClient,(const struct sockaddr *)&addr,sizeof(struct sockaddr_in));
    if(err == -1)
    {
        printf(" ERR:connect.... \n");
        close(SocketClient);
        return -1;
    }
#endif
    int len = sizeof(struct sockaddr);
    while(1)
    {
        //数据发送处理
        if(fgets(RecvBuff,Max - 1,stdin))
        {
#if UDP_ONE
            err = send(SocketClient, RecvBuff, strlen(RecvBuff), 0);
#else
            err = sendto(SocketClient, RecvBuff, strlen(RecvBuff), 0,(const struct sockaddr *)&addr, len); //不使用connect则需要用sendto
#endif
            if(err <= 0)
            {
                printf(" ERR:send... \n");
                close(SocketClient);
                return -1;
            }
        }
    }






    return 0;
}

