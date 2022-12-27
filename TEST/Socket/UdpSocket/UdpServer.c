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
 * bind
 * recvfrom/sendto
*/
#define POINT       8885
#define MAX         1000
int main(int argc,char* argv)
{
    struct sockaddr_in addr;        //存储服务端的信息
    struct sockaddr_in clientaddr;  //存储接收到客户端的信息   
    unsigned char RecvBuff[MAX] = "\0";
    unsigned char RecvClientBuff[30] = "OK,I get it";
    int SocketServer;
    int err;
    int length = 0;
    SocketServer = socket(AF_INET,SOCK_DGRAM,0);    //数据报
    if(SocketServer == -1)
    {
        printf(" ERR: socket... \n");
        return -1;
    }
    bzero(&addr,sizeof(struct sockaddr_in));
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(POINT);
    err = bind(SocketServer, (const struct sockaddr *)&addr,sizeof(struct sockaddr_in));
    if(err == -1)
    {
        printf(" ERR:bind... \n");
        close(SocketServer);
        return -1;
    }
    while(1)
    {
        //数据接收处理
        int len = sizeof(struct sockaddr_in);
        length = recvfrom(SocketServer, RecvBuff, MAX - 1, 0,(struct sockaddr *)&clientaddr, &len);
        if(length <= 0)
        {
            // printf(" ERR: Can't recv from %s \n",inet_ntoa(addr.sin_addr));
            // return -1;
        }
        else
        {
            RecvBuff[MAX] = '\0';
            printf(" Server: Recv %s from %s.... \n",RecvBuff,inet_ntoa(clientaddr.sin_addr));
            length = 0;
            memset(RecvBuff,0,sizeof(RecvBuff));
            // //数据发送
            // err = send(SocketServer, RecvClientBuff, strlen(RecvClientBuff), 0);
            // if(err <= 0)
            // {
            //     printf(" ERR:send... \n");
            //     close(SocketServer);
            //     return -1;
            // }
        }
        


    }





    close(SocketServer);
    return 0;
}


