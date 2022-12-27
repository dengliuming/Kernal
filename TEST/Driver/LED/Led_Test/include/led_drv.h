#ifndef _H_LEDDRIV_
#define _H_LEDDRIV_
#include "Led_resource.h"
void G_RegesterLedOperation(int mior);
void G_DestroyLedOperation(int mior);
void G_GetGpioResourcePtr(struct gpio_resource *gpio_re);
#endif
