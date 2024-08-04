R# Notes on potentially using a RPi to replace the CD Rom

## Pins

### Serial Data
#### CDTV Data Signals 
So this is for the Subcode - https://en.wikipedia.org/wiki/Compact_Disc_subcode  
EFFK [I] (EFM Frame clock output duty = 50%)  
SCCK [O] (Shift clock for serial subcode data output)  
SBCP [I] (Subcode Pch output Pch~Wch serial data output)  
SCOR [I] (Subcode sync output S0+s1)  




### Data
#### CDTV Data Signals 
DB0-7
#### RPi
GPIO4
GPIO5
GPIO6
GPIO7  (SPI)
GPIO8  (SPI)
GPIO9  (SPI)
GPIO10 (SPI)
GPIO11 (SPI)

### Digital Audio
#### CDTV Signals 
AEMP / EMPHASIS [I] (Audio Deemphasis)   
DATA / D0 [I] (CD Audio Data)   
LRCLK / LRCK [I] (Audio Left/Right Clock)   
BCLK / DSCK [I] (CD Audio Clock)   

#### RPi
The RPi has PCM Digital audio (Noice!)  
https://pinout.xyz/pinout/pcm  

GPIO 19 (FS) "LRCLK"  
GPIO 18 (CLK) "BCLK"  
GPIO 20 (DIN)   
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

