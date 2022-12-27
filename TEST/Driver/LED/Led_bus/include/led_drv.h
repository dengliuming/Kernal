#ifndef _LEDDRV_H
#define _LEDDRV_H

#include "led_operation.h"

void G_LedDevicesCreate(int minor);
void G_LedDevicesDestroy(int minor);
void G_RegesterLedOperation(struct led_operations *opr);

#endif /* _LEDDRV_H */
