# CN9 - CDROM connector

This is a work in progress. A handy place to put my notes...

## Description 

Commodore P/N 903345-20 HEADER ASSY 40 PIN 2.54 PITCH

Note that 42 pins are listed, this is because two pins (41 & 42) are not used/connected. 

The CDTV CDROM interface is reportedly a modified Panasonic MKE (Matsushita Kotobuki Electronics) interface, where this differs from the "Sound Blaster" PC drives is that the CDTV interface also bundles CD audio into the connector. This also differs from the A570. 

## General Notes

A lot of the A570 stuff is somewhat dubious as I can hardly read the schematics! Take any pin numbers with a pinch of salt. 

## Pinout [I/O] (Guessed description)

Signal names are as given in the CDTV Service Manual. Where signals are given on the pin and wire they're both noted.  

I/O is in relation to the CDTV, so O is from CDTV to drive, I is Drive to CDTV, U means Unknown, B is bidirectional, NC is not connected

1. CDRST [O]
2. GND
3. EFFK [I] (EFM Frame clock output duty = 50%)
4. SCCK [O] (Shift clock for serial subcode data output)
5. SBCP [I] (Subcode Pch output Pch~Wch serial data output)
6. SCOR [I] (Subcode sync output S0+s1) 
7. GND
8. GND
9. C16M [I] (16MHz DAC and LC8951 Clock)
10. GND
11. XAEN [I]
12. GND
13. AEMP / EMPHASIS [I] (Audio Deemphasis)
14. DATA / D0 [I] (CD Audio Data)
15. LRCLK / LRCK [I] (Audio Left/Right Clock)
16. BCLK / DSCK [I] (CD Audio Clock)
17. Mute [NC] (Mute signal).
18. GND
19. INAC [I] (Indicator Power/Status)
20. STCH [I] (CD-Status bit 0?)
21. ENABLE [O] (CD-Data enable?)
22. DRQ / WAIT [I] (Data ReQuest?? )
23. HWR [O] (Host Write Request? - Signals to the drive that command bursts are to be sent)
24. GND
25. DTEN [I] (CD-Status bit 1?)
26. HRD [O] (Host Read Request? )
27. STEN [I] (CD-Status bit 2?)
28. CMD [O] (CD-Status / Data enable?)
29. EOP [NC - I] (End-of-Process)
31. GND
32. DB7 [B] (Data Bit 7)
33. GND
34. DB6 [B] (Data Bit 6)
35. DB5 [B] (Data Bit 5)
36. DB4 [B] (Data Bit 4)
37. GND
38. DB3 [B] (Data Bit 3)
39. DB2 [B] (Data Bit 2)
40. DB1 [B] (Data Bit 1)
41. DB0 [B] (Data Bit 0)
42. GND via 4.7k resistor.
43. GND

## Pin Description

### 1 (CDRST) - Pin 3 on A570
 Reset?   
 NAND of IOR,IOW -> NOR of IFRST (InterFace ReSeT)  
### 3 EFFK - Pin 5 on A570
This is connected to the MN188161 Microprocessor.
This is for the Subcode or subchannel data
EFM Frame clock output duty = 50%
### 4 SCCK - Pin 6 on A570
This is for the Subcode or subchannel data
Shift clock for serial subcode data output
### 5 SBCP - Pin 7 on A570
This is for the Subcode or subchannel data
Subcode Pch output Pch~Wch serial data output  
### 6 SCOR - Pin 8 on A570
This is for the Subcode or subchannel data
Subcode sync output S0+s1  
This triggers an inturrupt when a subcode is "ready" to be read.
Connected via a 74LS244 to the Controller chip 

### 9 C16M - Pin 11 on A570
 Feeds into LC7883M D/A Converter pin 24  
 Feeds from LC7883M D/A Converter pin 25 via 100k resistor  
 16MHz clock.
### 11 XAEN  - Pin 13 on A570
This is connected to the MN188161 Microprocessor pin 45 (PI4)
My suspicion is that this is related to the XTA "AEN" signal which (and this took a lot of hunting down) is defined as follows:  
```Now the DMA controller has control of the bus, it presents the memory address on the address bus and asserts AEN, which signals to IO devices not involved in the DMA transfer to disregard the bus cycle```

This may not be correct however, my secondary guess is it's "eXternal Audio ENable", ie U62 has requested music be played from a CD. 

### 13 AEMP - Pin 15 on A570
 Feeds into LC7883M D/A Converter pin 15 from the M50422P CD Digital DSP pin 3
 de-emphasis set   
 So, this basically harks back to the early days of CD   

 ```
 Emphasis came about because of early converter design. The entire sampling process was new, and A to D converters exhibited low level noise because of bad linearity in the conversion process. This process added some high frequency broadband noise to the digital signal. Manufacturers overcame this byproduct by boosting (emphasis) the high frequencies during the conversion from analog to digital, and then rolling off (de-emphasis) the high frequencies by the same amount after the conversion back from digital to analog. This process was optional and there was a switch to select emphasis on each track during record. A flag was set in the digital bit-stream, which automatically activated de-emphasis during playback. All CD players, DVD players, and DAT machines detect this flag and turn on a high frequency roll-off in the analog domain during playback. If the digital signal contains emphasis and the flag is missing or turned off, then the roll-off does not occur and the audio will be brighter than normal.

This emphasis feature was the biggest reason why different CD players sounded different when playing back the same CD, or DAT machines differed playing back the same DAT tape. The digital part and the conversion to analog were basically the same in all of the machines. The de-emphasis circuit was implemented in the analog domain using the least expensive circuit to perform the operation. There was high-end EQ on the output of every digital playback device, and there was no standard or calibration for how it was performed. If you played back a CD without emphasis, then all of the CD players sounded pretty much the same. If you played a CD with emphasis, then each playback device sounded very different from every other player.

Producers and engineers started turning off the emphasis switches. Converters were getting better so there was less converter noise, and the use of de-emphasis circuits was eliminated.
```
 
### 14 DATA - Pin 16 on A570

pin 67
 Digital Audio Data using I²S
 Feeds into LC7883M D/A Converter pin 6 from the M50422P CD Digital DSP pin 67. Also connected to LC8951
 Bit serial from MSB
### 15 LRCLK - Pin 17 on A570
 Digital Audio Data using I²S
 Feeds into LC7883M D/A Converter pin 7  
 LR CLK (Left/Right?)    
 LRCK = "H" CH1    
 LRCK = "L" CH2    
### 16 BCLK - Pin 19 on A570
 Digital Audio Data using I²S
 Feeds into LC7883M D/A Converter pin 5  
 Bit CLK   
### 17 MUTE (N/C) - Pin 19 A570 (CDMUTE)
  Mute Audio... Not used on the CDTV but is connected on the A570 where its from the drive. 
  I had presumed this to be a signal from the CDTV to the drive *TO* mute audio but now I believe it to be the other way round, a signal that audio has been muted. 
   
### 19 INAC
 Indicator LED. 

### 20 STCH
 This is connected to the MN188161 Microprocessor. From the MKE pinout it's suggested this is CD-Status bit 0
 This stands for STatus CHange and triggers an interrupt on the Tri-Port. This generates a level 2 interrupt on the 68k which is picked up by the cdtv.device which then sends MKE protocol command $81. 
 I don't know what $81 is. 
 
### 21 *ENABLE
```To send a command the host computer sets the ENABLE and CMD pins to LOW and loads one or more command bites into the COMIN register (of the LC8951)```

### 22 DRQ (WAIT)
According to the datasheet the function depends on the state of the SELDRQ input, one of the two options
1. When SELDRQ is HIGH (that is, during software transfer mode), the LS8950 sets the WAIT output to LOW to signal the host to suspend the data transfer. WAIT is held high while DTEN is HIGH, and while the LC8950 is not transferring data to the host.
2. When SELDRQ is LOW (that is, during DMA transfer mode), WAIT functions as a DRQ (Data Request) output to the host computer. WAIT remains LOW while DTEN is HIGH, and while the LC8951 is not transfering data to the host.

It is presumed that the CDTV uses option 2 both from the name as well as the use of the DMAC and based on the design of the A570 where SELDRQ is held LOW via a 6.8K resistor to ground.

### 23 *HWR
 Connects to the LC8951 on the drive - Host Data Write Input (why not Host Write Ready?)
 ``` The host interface also has a built in 8-byte FIFO command buffer to recieve instructions from the host computer. When the host signals the LC8951 using the HWR pin, command bursts of up to eight bytes in length can be written to the the buffer. When the host writes to the command buffer the LC8950 sends a command interrupt to the controller. Note, however, that the LC8951 itself does not interpret commands written to the command buffer.```

### 25 DTEN
 Connects to the LC8951 on the drive - Data Enable Output.  
 Informs the host that data transfer will start.
 This output is set to LOW to signal the host computer that data is ready to be transfered.
### 26 *HRD
 Connects to the LC8951 on the drive - Host Data Read Input (Why not Host Read Data?) 
 If the read signals from the host exceed the LC8951 maximum data rate (about 2.3MB/s), the LC8951 sets the DRQ (WAIT) pin to LOW. The host must then hold HRD low to delay the read until the DRQ (WAIT) pin goes HIGH. 

### 27 STEN
Connects to the LC8951 on the drive - Status Enable Output.  
 ```The controller and the host perform handshaking using signals at the STEN pin```  
 This output is set to LOW to signal the host computer that the status byte is ready to be read out.  
 
### 28 *CMD
 Connects to the LC8951 on the drive - Host Command/Data select 
 When the host sees that DTEN is LOW it sets CMD to HIGH instructing the LC8951 to transfer successive bytes.  

### EOP - N/C
 End-of-Process flag.  
 The LC8951 sets this flag to LOW on sending the last byte to the host computer using either software or DMA data transfers.  
 Not used on the CDTV or A570.  
 
 
### 31,33-35,37-40 - DB7-0

Bidirectional 8 bit data bus. 
This is not only used for transfering data to the "host" (ie the CDTV) but also commands to the controller and data from the controller. 

## MKE Interface (similar)
The CDTV was presumed to use a modified MKE interface... I'm not *entirely* sure that's correct, I suspect that the A570 uses a modified MKE, the CDTV is a bit funkier. 

1. GND               
2. CD-Reset                (RESET)
3. GND               
4. GND                     
5. GND               
6. operation Mode bit 0    (/DRIVE SELECTO)
7. GND               
8. operation Mode bit 1    (/DRIVE SELECTO)
9. GND              
10. CD-Write                (IOW)
11. GND              
12. CD-Read                 (IOR)
13. GND              
14. CD-Status bit 0         (STCH)
15. GND              
16. n/c                     (ADPCM ENABLE)
17. GND              
18. n/c                     (DRQ)         
19. GND              
20. CD-Status bit 1         (DTEN)        
21. GND              
22. CD-Data enable          (ENABLE)      
23. GND              
24. CD-Status bit 2         (/STEN)       
25. GND              
26. CD-Status / Data enable (CMD)         
27. GND              
28. CD-Status bit 3         (EOP)         
29. GND              
30. GND                     
31. CD-Data 7 (D7)   
32. CD-Data 6 (D6)
33. GND              
34. CD-Data 5 (D5)
35. CD-Data 4 (D4)   
36. CD-Data 3 (D3)
37. GND              
38. CD-Data 2 (D2)
39. CD-Data 1 (D1)   
40. CD-Data 0 (D0)

## Command set (MKE) 

It appears that MKE tailored each device, so while the Panasonic interface is undoubtedly similar its not the same. 

Commands are 7 bytes long with the first byte being the command byte (upto??)

```
Command         Hex code                # bytes Resp.   Note
===========================================================================

Seek            01  M  S  F  0  0  0          1
Read            02 ss ss ss ll ll 00            ss=24 bit start sector, ll=26 bit number of sectors to read
Motor on        04
Motor off       05
Play (LSN)      09
Play (MSF)      0a
Play track      0b st si et ei 00 00            st=start track, si=start index, et=stop track, ei=stop index
CD-ROM Status   81                              See status codes below
Read Error?     82
Model Name      83
Select Mode 1/2 84 ?? sh sl 00 ?? 00            sh=sector size high byte (*256), sl=sector size low byte
Read SubQ       87
Volume summary  89                              
Read TOC        8a ml tt 00 00 00 00            ml=select MSF or LSN values, tt=track# to start from or 0 for volume summary
Pause/Resume    8b pp 00 00 00 00 00            $80 or 0 will pause/unpause
Front panel     a3 ed 00 00 00 00 00            Enable or disable SPI interface ($20 is enable, 0 is disable).
```
## CDROM status

This is an 8 bit status code consisting of the following bits. 

```
#define MATSU_STATUS_READY ( 1 << 0 ) /* driver ready */
#define MATSU_STATUS_DOORLOCKED ( 1 << 1 ) /* door locked */
#define MATSU_STATUS_PLAYING ( 1 << 2 ) /* drive playing */
#define MATSU_STATUS_SUCCESS ( 1 << 3 ) /* last command was successful */
#define MATSU_STATUS_ERROR ( 1 << 4 ) /* last command failed */
#define MATSU_STATUS_MOTOR ( 1 << 5 ) /* spinning */
#define MATSU_STATUS_MEDIA ( 1 << 6 ) /* media present (in caddy or tray) */
#define MATSU_STATUS_DOORCLOSED ( 1 << 7 ) /* tray status */
```

## Error codes (MKE) - CDTV Presumed similar
```
00      No error
01      Soft read error after retry
02      Soft read error after error correction
03      Not ready
04      Cannot read TOC
05      Hard read error
06      Seek didn't complete
07      Tracking servo failure
08      Drive RAM error
09      Self-test failed
0a      Focusing servo failure
0b      Spindle servo failure
0c      Data path failure
0d      Illegal logical block address
0e      Illegal field in CDB
0f      End of user encountered on this track ?
10      Illegal data mode for this track
11      Media changed
12      Power-on or reset occured
13      Drive ROM failure
14      Illegal drive command from the host
15      Disc removed during operation
16      Drive hardware error
17      Illegal request from host
```

## Digital Audio

The CDTV sends two channel digital audio from the CDROM to LC7883M D/A, this requires three connections.
1. Serial clock (SCK),[1] a.k.a. bit clock (**BCLK**).[3]
2. Word select (WS);[1] a.k.a. left-right clock (**LRCLK**)[3] or frame sync (FS).[4]; 0 = Left channel, 1 = Right channel[1]
3. Serial data (SD),[1] a.k.a. **DATA**, SDATA, SDIN, SDOUT, DACDAT, ADCDAT[3]

# CN26

This doesn't deserve its own page but needed somewhere for it. 

## Description 

Commodore P/N 252616-03 HEADER ASSY 3 PIN 2 PITCH  
I believe these to be using Molex 51004 series connectors, the 53014, 53015 and 53025 are the corresponding matching headers, this is therefore presumed to be a Molex 53014-0310, the right angle version (used on the CDROM) is probably a Molex 53015-0310 (53025 is a "through board" type connector).
A Molex 51004-0300 would plug into it which uses 50011-8000 crimp terminals.  

Unfortunately all except the 50011-8000 crimp terminals are obsolete and NLA

## Pinout [I/O] (Guessed description)

While this is labled in the schematics as "CDROM INTERFACE CD AUDIO" I don't think this carries audio and instead think this is I²C to allow control of playing Audio CD's outside of software control by the Amiga/CDTV. 

1. SCK [U] 
2. SDATA [U]
3. GND [U]

These connect to SBT and SBI on the MN188161 which are described as 
1. SBT - Sync. Serial interface clock I/O pin.
2. SMI - Sync. Serial interface data input pin. 

# Sources

1. C4ptFuture (massive thanks!) https://github.com/C4ptFuture
2. CDTV Service Manual
3. A570 Schematics (badly scanned and barely readable, if anyone has better copy please let me know!)
4. https://en.wikipedia.org/wiki/Panasonic_CD_interface
5. https://www.chiark.greenend.org.uk/~theom/electronics/panasoniccd.html
6. Sanyo LC7883 datasheet - https://archive.org/details/sanyo-lc8950-lc8951-lc7883
7. Sanyo LC8951 datasheet - https://archive.org/details/sanyo-lc8950-lc8951-lc7883
8. https://en.wikipedia.org/wiki/I%C2%B2S
9. https://en.wikipedia.org/wiki/Compact_Disc_subcode
10. https://www.lo-tech.co.uk/tag/xt-ide/
11. WinUAE Source code https://github.com/tonioni/WinUAE/blob/master/cdtv.cpp
 







