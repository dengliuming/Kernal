#ifndef _H_GPIO_RESOURCE_
#define _H_GPIO_RESOURCE_

/* 例如： GPIO3_0 
    bit[31:16]  = group
    bit[15:0]   = pin 
*/
#define GROUP(X)    (X>>16)
#define PIN(X)      (X&0XFF)
#define GPIO_PIN(g,p)   ((g<<16)|(p))   //获取地址

struct gpio_resource {
    int (*init) (int);
    int (*ctl) (int,char);
};


#endif

