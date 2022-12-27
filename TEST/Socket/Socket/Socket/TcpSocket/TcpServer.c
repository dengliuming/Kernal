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
 *  socket
 *  bind
 *  listen
 *  accept
 *  send/recv
 */
#define SERVER_POINT    8885
#define BACKLOG         2
#define MAX             1000
int main(int argc,char** argv)
{
    int iSocketServer,iRet;
    int iSocketClient;
    struct sockaddr_in my_addr;
    struct sockaddr_in socket_client;
    int icClientNum = 0;
    unsigned char ucRecvBuff[MAX];
    int RecvLen;
    int len = 0;
    unsigned char ucClientBuff[MAX];
    signal(SIGCHLD,SIG_IGN);    //处理僵尸进程
    iSocketServer = socket(AF_INET, SOCK_STREAM, 0);    //IPv4网络协议，流传输，IPv4 Internet协议指定套接字使用的特定协议0（默认）
    if(iSocketServer == -1)
    {
        printf(" Error socket file... \n");
        return -1;
    }
    memset(&my_addr,0,sizeof(my_addr));
    my_addr.sin_family = AF_INET;
    my_addr.sin_port = ntohs(SERVER_POINT); //转换成符合网络字节的顺序
    my_addr.sin_addr.s_addr = INADDR_ANY; //INADDR_ANY:检测所有IP
    // bzero(my_addr.sin_zero,sizeof(my_addr.sin_zero));
    iRet = bind(iSocketServer,(const struct sockaddr *)&my_addr,sizeof(struct sockaddr_in));
    if(iRet == -1)
    {
        printf(" Error bind... \n");
        return -1;
    }
    iRet = listen(iSocketServer, BACKLOG);
    if(iRet == -1)
    {
        printf(" Error listen... \n");
        return -1;
    }
    while (1)
    {
        int Addr_len = sizeof(struct sockaddr_in);
        iSocketClient = accept(iSocketServer, (struct sockaddr *)&socket_client, &Addr_len);  //等待接受连接,存储客户端地址信息
        if(iRet != -1)
        {
            icClientNum++;
            printf("Get connect! \n");
            printf(" socket_client.sin_addr = %s \n",inet_ntoa(socket_client.sin_addr));
            if(!fork()) //程序执行到这时候，打开并复制出相同代码的新的进程（子进程）
            {
                /* 子进程 */
                while (1)
                {
                    /* 接收客户端发来的数据，并显示出来 */
                    unsigned int  len = sizeof(ucRecvBuff) - 1;
                    int flag = 0;
                    ucRecvBuff[MAX] = '\0';
                    RecvLen = recv(iSocketClient, ucRecvBuff, len, flag);
                    if(RecvLen > 0)
                    {
                        
                        printf(" Get msg from cline %s \n",inet_ntoa(socket_client.sin_addr));
                        printf(" icClientNum = %d \n",icClientNum);
                        printf(" ucRecvBuff = %s \n",ucRecvBuff);
                    }
                    else
                    {
                        close(iSocketClient);
                        close(iSocketServer);
                        return -1;
                    }
                    //数据发送
                    if(fgets(ucClientBuff,MAX - 1,stdin))
                    {
                        len = send(iSocketClient, ucClientBuff, strlen(ucClientBuff), 0);
                        if(len < 0)
                        {
                            printf(" ERR: send..\n ");
                            close(iSocketClient);
                            close(iSocketServer);
                            return -1;
                        }
                    }
                }
            }
            else
            {
                /* 主进程 */
            }
        }
    }
    



    close(iSocketClient);
    close(iSocketServer);
    return 0;
}



