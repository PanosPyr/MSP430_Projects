#include "led.h"
#include <msp430.h>

void led_init()
{
    P1DIR |= 0x01;
}

void led_toggle()
{
    P1OUT ^= 0x01;
}