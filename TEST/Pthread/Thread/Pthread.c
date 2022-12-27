#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

/*
    线程进程区别：
        线程：一个man中有多个while；因为资源（全局变量）共享，数据处理效率高；一个线程只能有一个进程
        进程：多个man函数，数据处理效率低；一个进程中可以存在多个线程
*/

#define MAX         1000
static char g_SendBuff[MAX];
static int g_hasData = 0;
static void *start_routine (void* data)
{
    while(1)
    {
        /* 等待通知 */
        while (g_hasData == 0);             //不会进入休眠，会消耗大量的CPU资源
        /* 打印数据 */
        printf(" recv: %s \n",g_SendBuff);
        g_hasData = 0;
    }
    return NULL;
}

int main(int argc,char** argv)
{
    int err = 0;
    pthread_t tread;
    /* 1、创建接收线程 */
    err = pthread_create(&tread, NULL,start_routine, NULL);
    if(err != 0)
    {
        printf(" ERR:pthread_create... \n");
        return -1;
    }

    /* 2、主线程读取标准输入，并发给接收线程 */
    while(1)
    {
        if(fgets(g_SendBuff, MAX -1, stdin))  //标准输入到BUFF中    //没有输入时，会进入休眠
        {   
            /* 通知接收线程 */
            g_hasData = 1;
        }   
    }

    return 0;
}




