#ifndef _LED_OPERATION_H
#define _LED_OPERATION_H
struct led_operations{
    int (*init)(int whitch);
    int (*ctl)(int whitch,char status);
}

struct led_operations *GetBordLedOperations(void);

#endif
