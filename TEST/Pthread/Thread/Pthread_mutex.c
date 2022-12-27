#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include <semaphore.h>  //信号量

/*
    线程进程区别：
        线程：一个man中有多个while；因为资源（全局变量）共享，数据处理效率高；一个线程只能有一个进程
        进程：多个man函数，数据处理效率低；一个进程中可以存在多个线程
*/
/* 互斥锁
 * static pthread_mutex_t g_tMutex = PTHREAD_MUTEX_INITIALIZER;    //互斥对象初始化器
 * pthread_mutex_lock   锁
 * pthread_mutex_unlock 解锁
*/
#define MAX         1000
static char g_SendBuff[MAX];
static sem_t g_sem;
static pthread_mutex_t g_tMutex = PTHREAD_MUTEX_INITIALIZER;    //互斥对象初始化器
static void *start_routine (void* data)
{
    int len;
    while(1)
    {
        /* 等待通知，lock */
        len = sem_wait(&g_sem);
        if(len == 0)
        {   
            pthread_mutex_lock(&g_tMutex);  
            /* 打印数据 */
            printf(" recv: %s \n",g_SendBuff);
            pthread_mutex_unlock(&g_tMutex);
        }
    }
    return NULL;
}

int main(int argc,char** argv)
{
    int err = 0;
    pthread_t tread;
    char buff[MAX];
    /* 初始化信号量 */
    /*
        pshared的值为0，那么这个信号量将在进程的线程之间共享，并且应该位于一个对所有线程都可见的地址(例如，一个全局变量，或者一个动态分配在堆上的变量)。
    */
    err = sem_init(&g_sem, 0, 0);  
    if(err != 0)
    {
        printf(" ERR:sem_init... \n");
        return -1;
    }
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
        fgets(buff, MAX -1, stdin);  //标准输入到BUFF中    //没有输入时，会进入休眠 
        pthread_mutex_lock(&g_tMutex);      
        memcpy(g_SendBuff, buff, MAX);
        pthread_mutex_unlock(&g_tMutex);
        /* 通知接收线程 */
        /* 释放信号,唤醒unlock */
        sem_post(&g_sem);
    }

    return 0;
}




