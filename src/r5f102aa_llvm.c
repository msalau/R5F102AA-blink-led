#include "iodefine.h"
#include "iodefine_ext.h"

int main(void)
{
    /* Switch P2[0:3] to digital mode */
    ADPC = 0x01;
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
