#include "iodefine.h"

int main(void)
{
    /* Make P20 output */
    PM2_bit.no0 = 0;

    for (;;)
    {
        /* Wait a little */
        for (volatile unsigned char i = 100; i; i--);
        /* Toggle P20 */
        P2_bit.no0 ^= 1;
    }

    return 0;
}
