# CN9 - CDROM connector

This is a work in progress. A handy place to put my notes...

## Description 

Commodore P/N 903345-20 HEADER ASSY 40 PIN 2.54 PITCH

Note that 42 pins are listed, this is because two pins (41 & 42) are not used/connected. 

The CDTV CDROM interface is a modified Panasonic MKE (Matsushita Kotobuki Electronics), where this differs from the "Sound Blaster" PC drives is that the CDTV interface also bundles CD audio into the connector. 

## Pinout [I/O] (Guessed description)

Signal names are as given in the CDTV Service Manual. Where signals are given on the pin and wire they're both used.  

I/O is in relation to the CDTV, U means Unknown, NC is not connected


1. _*RESET*_ [O]
2. GND
3. EFFK [I] (EFM frame clock ouput duty = 50%)
4. SCCK [O]
5. SBCP [I]
6. SCOR [I] (Subcode sunc output S0+s1)
7. GND
8. GND
9. C16M [I?] (16MHz DAC Clock)
10. GND
11. XAEN [U]
12. GND
13. AEMP / EMPHASIS [I] (Audio Deemphasis)
14. DATA / D0 [I] (CD Audio Data)
15. LRCLK / LRCK [I] (Audio Left/Right Clock)
16. BCLK / DSCK [I] (CD Audio Clock)
17. Mute [NC]
18. GND
19. INAC [I] (Indicator Power/Status)
20. STCH [U] (CD-Status bit 0?)
21. ENABLE [U] (CD-Data enable?)
22. DRQ / WAIT [U] (Data ReQuest?? )
23. HWR [O] (Host Write Request? - Signals to the drive that command bursts are to be sent)
24. GND
25. DTEN [U] (CD-Status bit 1?)
26. HRD [O] (Host Read Request? )
27. STEN [I] (CD-Status bit 2?)
28. CMD [U] (CD-Status / Data enable?)
29. N/C (Note that this is however connected to EOP - "End-of-Process" at the drive)
31. GND
32. DB7 [I/O] (Data Bit 7)
33. GND
34. DB6 [I/O] (Data Bit 6)
35. DB5 [I/O] (Data Bit 5)
36. DB4 [I/O] (Data Bit 4)
37. GND
38. DB3 [I/O] (Data Bit 3)
39. DB2 [I/O] (Data Bit 2)
40. DB1 [I/O] (Data Bit 1)
41. DB0 [I/O] (Data Bit 0)
42. GND via 4.7k resistor.
43. GND

## Pin Description

### 1 (TBD)
 Reset?   
 NAND of IOR,IOW -> NOR of IFRST (InterFace ReSeT)  
### 3 EFFK
### 5 SBCP
### 6 SCOR
### 9 C16M
 Feeds into LC7883M D/A Converter pin 24  
 Feeds from LC7883M D/A Converter pin 25 via 100k resistor  
 16MHz clock.
### 11 XAEN
### 13 AEMP
 Feeds into LC7883M D/A Converter pin 15  
 de-emphasis set   
 So, this basically harks back to the early days of CD   

 ```
 Emphasis came about because of early converter design. The entire sampling process was new, and A to D converters exhibited low level noise because of bad linearity in the conversion process. This process added some high frequency broadband noise to the digital signal. Manufacturers overcame this byproduct by boosting (emphasis) the high frequencies during the conversion from analog to digital, and then rolling off (de-emphasis) the high frequencies by the same amount after the conversion back from digital to analog. This process was optional and there was a switch to select emphasis on each track during record. A flag was set in the digital bit-stream, which automatically activated de-emphasis during playback. All CD players, DVD players, and DAT machines detect this flag and turn on a high frequency roll-off in the analog domain during playback. If the digital signal contains emphasis and the flag is missing or turned off, then the roll-off does not occur and the audio will be brighter than normal.

This emphasis feature was the biggest reason why different CD players sounded different when playing back the same CD, or DAT machines differed playing back the same DAT tape. The digital part and the conversion to analog were basically the same in all of the machines. The de-emphasis circuit was implemented in the analog domain using the least expensive circuit to perform the operation. There was high-end EQ on the output of every digital playback device, and there was no standard or calibration for how it was performed. If you played back a CD without emphasis, then all of the CD players sounded pretty much the same. If you played a CD with emphasis, then each playback device sounded very different from every other player.

Producers and engineers started turning off the emphasis switches. Converters were getting better so there was less converter noise, and the use of de-emphasis circuits was eliminated.
```
 
### 14 DATA 
 Digital Audio Data using I²S
 Feeds into LC7883M D/A Converter pin 6  
 Bit serial from MSB  
### 15 LRCLK
 Digital Audio Data using I²S
 Feeds into LC7883M D/A Converter pin 7  
 LR CLK (Left/Right?)    
 LRCK = "H" CH1    
 LRCK = "L" CH2    
### 16 BCLK
 Digital Audio Data using I²S
 Feeds into LC7883M D/A Converter pin 5  
 Bit CLK   
### 17 MUTE (N/C)
 Mute Audio... Not used
### 19 INAC
 Indicator LED. 

### 20 STCH
 CD-Status bit 0
### 21 ENABLE
```To send a command the host computer sets the ENABLE and CMD pins to LOW and loads one or more command bites into the COMIN register (of the LC8951)```

### 22 DRQ (WAIT)

### 23 HWR
 Connects to the LC8951 on the drive.   
 
 ``` The host interface also has a built in 8-byte FIFO command buffer to reciev instructions from the host computer. When the host signals the LC8951 using the HWR pin, command bursts of up to eight bytes in length can be written to the the buffer. When the host writes to the command buffer the LC8950 sends a command interrupt to the controller. Note, however, that the LC8951 itself does not interpret commands written to the command buffer.```
### 25 DTEN
 CD-Status bit 1
 Informs the host that data transfer will start.
### 26 HRD
 If the read signals from the host exceed the LC8951 maximum data rate (about 2.3MB/s), the LC8951 sets the DRQ (WAIT) pin to LOW. The host must then hold HRD low to delay the read until the DRQ (WAIT) pin goes HIGH. 
### 27 STEN
 ```The controller and the host perform handshaking using signals at the STEN pin```
 
### 28 CMD
 CD-Status / Data Enable    
 When the host sees that DTEN is LOW it sets CMD to HIGH instricting the LC8951 to transfer successive bytes.  

 
### 31,33-35,37-40 - DB7-0

Bidirectional 8 bit data bus. 
This is not only used for transfering data to the "host" (ie the CDTV) but also commands to the controller and data from the controller. 

## MKE Interface (similar)
The CDTV uses a modified MKE interface. 

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
32. CD-Data 6               (D6)
33. GND              
34. CD-Data 5               (D5)
35. CD-Data 4 (D4)   
36. CD-Data 3               (D3)
37. GND              
38. CD-Data 2               (D2)
39. CD-Data 1 (D1)   
40. CD-Data 0               (D0)

## Command set (MKE) - CDTV Presumed similar
```
Command         Hex code                # bytes Resp.   Note
===========================================================================

Seek            01 M S F 0 0 0          1
Spin up         02 0 0 0 0 0 0          1
Status          05 0 0 0 0 0 0          1       Only get status
Tray out        06 0 0 0 0 0 0          1       Eject tray
Tray in         07 0 0 0 0 0 0          1       Close tray
Abort           08                      1
Set mode        09 5 0 1 v 2 v          1       Set volume (patch), v = volume
                09 3 0 s s 0 0          1       Set speed
Reset           0a 0 0 0 0 0 0          0       Reset drive
Lock ctl        0c L 0 0 0 0 0          1       L=1 lock, L=0 unlock
Pause resume    0d P 0 0 0 0 0          1       P=80 resume, P=0 pause
Play MSF        0e m s f M S F          1       play from m-s-f to M-S-F
Play track/ind  0f t i T I 0 0          1       play from t i to T I
Read            10 M S F 0 0 n          1       read n blocks
Subchannel info 11
Read error      82 0 0 0 0 0 0          9       Get error code
Read version    83 0 0 0 0 0 0          11      Get version string
Get mode        84 5 0 0 0 0 0          6       Get audio volume & patch
Capacity        85 0 0 0 0 0 0          6
Read SubQ       87
Read UPC        88                              Read universal product code
Diskinfo        8b 0 0 0 0 0 0          7       Read disk info
Read TOC        8c 0 e 0 0 0 0          9       Read TOC entry e
Multisession    8d
Packet          8e

NOTE:
1. Last byte got from the drive is always a status byte.
2. Driver always should wait for no error & ready state before issuing
command.  (There may be a disk change between two commands, so we
don't know the state of the drive.)
================================================================
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

# Sources

1. CDTV Service Manual
2. https://en.wikipedia.org/wiki/Panasonic_CD_interface
3. https://www.chiark.greenend.org.uk/~theom/electronics/panasoniccd.html
4. Sanyo LC7883 datasheet - https://archive.org/details/sanyo-lc8950-lc8951-lc7883
5. Sanyo LC8951 datasheet - https://archive.org/details/sanyo-lc8950-lc8951-lc7883
6. https://en.wikipedia.org/wiki/I%C2%B2S








