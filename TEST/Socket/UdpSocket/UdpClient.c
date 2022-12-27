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
    struct sockaddr_in addrServer;
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
    err = connect(SocketClient,(const struct sockaddr *)&addr,sizeof(struct sockaddr_in));
    if(err == -1)
    {
        printf(" ERR:connect.... \n");
        close(SocketClient);
        return -1;
    }
    while(1)
    {
        //数据发送处理
        if(fgets(RecvBuff,Max - 1,stdin))
        {
            err = send(SocketClient, RecvBuff, strlen(RecvBuff), 0);
            if(err <= 0)
            {
                printf(" ERR:send... \n");
                close(SocketClient);
                return -1;
            }
        }
        // //数据接收处理
        // int len = sizeof(struct sockaddr_in);
        // length = recvfrom(SocketClient, RecvServerBuff, Max - 1, 0,(struct sockaddr *)&addrServer, &len);
        // if(length > 0)
        // {
        //     RecvServerBuff[Max] = '\0';
        //     printf(" Client :Recv %s from %s.... \n",RecvServerBuff,inet_ntoa(addrServer.sin_addr));
        //     length = 0;
        //     memset(RecvServerBuff,0,sizeof(RecvServerBuff));
        // }
    }






    return 0;
}

