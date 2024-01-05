#include <msp430.h>
#include "led.h"

//Change in code - Test branch

int main(void) {
    WDTCTL = WDTPW | WDTHOLD;               // Stop watchdog timer
    PM5CTL0 &= ~LOCKLPM5;                   // Disable the GPIO power-on default high-impedance mode
                                            // to activate previously configured port settings
    led_init();                          // Set P1.0 to output direction

    for(;;) {
        volatile unsigned int i;            // volatile to prevent optimization

        led_toggle();                      // Toggle P1.0 using exclusive-OR

        i = 10000;                          // SW Delay
        do i--;
        while(i != 0);
    }
    return 0;
}
