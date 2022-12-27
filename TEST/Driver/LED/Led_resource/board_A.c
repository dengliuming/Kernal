#include "include/led_resource.h"

static struct file_resource g_led_source = {
    .pin = GPIO_PIN(3,1),         //GPIO3_0
};
struct file_resource* Get_file_resource(void)
{
    return &g_led_source;
}
