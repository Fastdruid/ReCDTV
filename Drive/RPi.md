# Notes on potentially using a RPi to replace the CD Rom

## Pins

In order of GPIO not pin number.   
Direction is in relation to the CDTV so O is from CDTV to drive, I is Drive to CDTV, U means Unknown, B is bidirectional, NC is not connected.  
Obviously these directions are reversed for the RPi!   

| RPi Pin | Name | Type | Alt | CDTV Pin | Name | Direction |
| --- | --- | --- | --- | --- | --- | --- |
| 27 | GPIO 0 | I2C |  | 1 | CDRST | O |
| 28 | GPIO 1 | I2C |  | 4 | SCCK | O |
| 3 | GPIO 2 | I2C |  |  | SDATA | U |
| 5 | GPIO 3 | I2C |  |  | SCK | U |
| 7 | GPIO 4 | GPIO | GPCLK0 | 3 | EFFK | I |
| 29 | GPIO 5 | GPIO | GPCLK1 | 6 | SCOR | I |
| 31 | GPIO 6 | GPIO | GPCLK2 | 20 | STCH | I |
| 26 | GPIO 7 | SPI |  | 21 | ENABLE | O |
| 24 | GPIO 8 | SPI |  | 22 | DRQ | I |
| 21 | GPIO 9 | SPI |  | 23 | HWR | O |
| 19 | GPIO 10 | SPI |  | 25 | DTEN | I |
| 23 | GPIO 11 | SPI |  | 26 | HRD | O |
| 32 | GPIO 12 | PWM |  | 27 | STEN | I |
| 33 | GPIO 13 | PWM |  | 28 | CMD | O |
| 8 | GPIO 14 | UART |  | 5 | SBCP | I |
| 10 | GPIO 15 | UART |  | 11 | XAEN | I |
| 36 | GPIO 16 | GPIO |  | 31 | DB7 | B |
| 11 | GPIO 17 | GPIO |  | 33 | DB6 | B |
| 12 | GPIO 18 | PWM | PCM CLK | 16 | BCLK | I |
| 35 | GPIO 19 | PWM | PCM FS | 15 | LRCLK | I |
| 38 | GPIO 20 | PCM IN |  | 13 | AEMP | I |
| 40 | GPIO 21 | PCM OUT |  | 14 | DATA | I |
| 15 | GPIO 22 | GPIO |  | 34 | DB5 | B |
| 16 | GPIO 23 | GPIO |  | 35 | DB4 | B |
| 18 | GPIO 24 | GPIO |  | 37 | DB3 | B |
| 22 | GPIO 25 | GPIO |  | 38 | DB2 | B |
| 37 | GPIO 26 | GPIO |  | 39 | DB1 | B |
| 13 | GPIO 27 | GPIO |  | 40 | DB0 | B |
|  |  |  |  | 19 | INAC | I |
|  |  |  |  | 9 | C16M | I |
|  |  |  |  | 17 | Mute | NC/U |
|  |  |  |  | 29 | EOP | NC/I |

#### RPi
The RPi has PCM Digital audio (Noice!)  
https://pinout.xyz/pinout/pcm  

GPIO 19 (FS) "LRCLK"  
GPIO 18 (CLK) "BCLK"  
GPIO 20 (DIN) - AEMP???  
GPIO 21 (DOUT) "DATA"  

### I2C
https://pinout.xyz/pinout/i2c  
SCK (CLOCK)
SDATA (DATA)

#### I2C 0
GPIO 2 (DATA)  
GPIO 3 (CLOCK)  

#### I2C 1
GPIO 0 (DATA)  
GPIO 1 (CLOCK)  

