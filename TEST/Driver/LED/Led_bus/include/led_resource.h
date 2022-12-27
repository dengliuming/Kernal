#ifndef _LED_RESOURCE_H
#define _LED_RESOURCE_H

/* 例如： GPIO3_0 
    bit[31:16]  = group
    bit[15:0]   = pin 
*/
#define GROUP(X)    (X >> 16)
#define PIN(X)      (X&0xFFFF)
#define GPIO_PIN(g,p)   ((g << 16) | (p))
struct file_resource{
    int pin;
};

#endif
