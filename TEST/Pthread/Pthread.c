#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

void *fun1(void *arg)
{
    printf("%s arg = %p\n", __FUNCTION__, arg);
    while (1) 
    {
        sleep(1);
    }
}
void *fun2(void *arg)
{
    printf("%s", __FUNCTION__);
    pthread_cancel((pthread_t )(long)arg);
    pthread_exit(NULL);
}

int main(int argc, char **argv)
{
    pthread_t thread[2];
    int a = 10;
    int ret;
    int flag = 0;
    ret = pthread_create(&thread[0], 0,fun1, &a);
    if(ret != 0)
    {
        printf("pthread_create failed\n");
        return -1;
    }
    sleep(1);
    ret = pthread_create(&thread[1], 0,fun2, &thread[0]);
    while(1)
    {
        for(int i = 0; i < 2; i++)
        {
            if(pthread_tryjoin(thread[i], NULL) == 0)   //判断线程是否被回收
            {
                printf("%d\n", i);
                flag++;
            }
        }
        if(flag >= 2)
        {
            break;
        }
    }
    return 0;
}


