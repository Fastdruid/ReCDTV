# Notes on potentially using a RPi to replace the CD Rom

## Pins

IN order of GPIO not pin number 

| RPi Pin | Name | Type | Alt | CDTV Pin | Name |
| --- | --- | --- | --- | --- | --- |
| 27 | GPIO 0 | I2C |  | 1 | CDRST |
| 28 | GPIO 1 | I2C |  | 4 | SCCK |
| 3 | GPIO 2 | I2C |  |  | SDATA |
| 5 | GPIO 3 | I2C |  |  | SCK |
| 7 | GPIO 4 | GPIO | GPCLK0 | 3 | EFFK |
| 29 | GPIO 5 | GPIO | GPCLK1 | 6 | SCOR |
| 31 | GPIO 6 | GPIO | GPCLK2 | 20 | STCH |
| 26 | GPIO 7 | SPI |  | 21 | ENABLE |
| 24 | GPIO 8 | SPI |  | 22 | DRQ |
| 21 | GPIO 9 | SPI |  | 23 | HWR |
| 19 | GPIO 10 | SPI |  | 25 | DTEN |
| 23 | GPIO 11 | SPI |  | 26 | HRD |
| 32 | GPIO 12 | PWM |  | 27 | STEN |
| 33 | GPIO 13 | PWM |  | 28 | CMD |
| 8 | GPIO 14 | UART |  | 5 | SBCP |
| 10 | GPIO 15 | UART |  | 11 | XAEN |
| 36 | GPIO 16 | GPIO |  | 31 | DB7 |
| 11 | GPIO 17 | GPIO |  | 33 | DB6 |
| 12 | GPIO 18 | PWM | PCM CLK | 16 | BCLK |
| 35 | GPIO 19 | PWM | PCM FS | 15 | LRCLK |
| 38 | GPIO 20 | PCM IN |  | 13 | AEMP |
| 40 | GPIO 21 | PCM OUT |  | 14 | DATA |
| 15 | GPIO 22 | GPIO |  | 34 | DB5 |
| 16 | GPIO 23 | GPIO |  | 35 | DB4 |
| 18 | GPIO 24 | GPIO |  | 37 | DB3 |
| 22 | GPIO 25 | GPIO |  | 38 | DB2 |
| 37 | GPIO 26 | GPIO |  | 39 | DB1 |
| 13 | GPIO 27 | GPIO |  | 40 | DB0 |
|  |  |  |  | 19 | INAC |
|  |  |  |  | 9 | C16M |
|  |  |  |  | 17 | Mute |
|  |  |  |  | 29 | EOP |

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

