# Commodore CDTV CDROM Drive functionality

This is mostly my notes on how the CDTV CDROM drive works.

## CDTV Side

The CDTV uses a DMAC (390563-02) to generate an 8-bit IBM PC XT(A) (Not ST-506) interface (see below) the 8-bit data bus is is connected to the Tri-Port (6525A [225ns]) which is in Mode 1 (Interupt Mode), in this mode there are 16 I/O lines, 2 handshake lines and 5 interrupt lines. 

The interrupt lines are as follows:
PC0  
PC1 (SCOR)  
PC2 (STCH)  
PC3 (STEN)  
PC4 (DRQ)  
PC5 is the IRQ output and drives IRQ2  
  
PC6 and PC7 can be used as general purpose outputs or as data transfer signals for ports A and B. I think these are used as GPIO on the basis that MS [1:0] is defined as GENLOCK MODE SELECT (AMIGA)...
PC6 (MS0) - GENLOCK MODE SELECT  
PC7 (MS1) - GENLOCK MODE SELECT  

Then we have a number of command lines. 
PB0 CMD
PB1 ENABLE
PB2 XAEN
PB3 DTEN
PB4 WEPROM
PB5 DACATT 
PB6 DACST
PB7 DACLCH

Finally we have PA0-PA7, this takes EFM Encoded Subcode data via a serial to parallel converter and splits it to Channels W through P. 

R/W is handled using the normal R/W signal. The CS (Chip Select) for the Tri-Port is a NAND from A4 and CSX0 (XT Device Chip Select No.0)








 





## XT Interface


XTA Interface Pinouts

Pin	Signal	Pin	Signal
1.	-RESET	
2.	Ground
3.	Data Bit 7	
4.	Ground
5.	Data Bit 6	
6.	Ground
7.	Data Bit 5	
8.	Ground
9.	Data Bit 4	
10.	Ground
11.	Data Bit 3	
12.	Ground
13.	Data Bit 2	
14.	Ground
15.	Data Bit 1	
16.	Ground
17.	Data Bit 0	
18.	Ground
19.	Ground	
20.	Key (Missing pin)
21.	AEN	(DMARQ?)
22.	Ground
23.	-IOW	
24.	Ground
25.	-IOR	
26.	Ground
27.	-DACK 3	
28.	Ground
29.	DRQ 3	
30.	Ground
31.	IRQ 5	
32.	Ground
33.	Address Bit 1	
34.	Ground
35.	Address Bit 0	
36.	Ground
37.	-CS1FX	
38.	Ground
39.	-Drive Active	
40.	Ground

## Reference
Commodore A590 Service Manual
Commodore A570 schematics
https://en.wikipedia.org/wiki/Compact_Disc_subcode
https://dosdays.co.uk/topics/xt_ide_vs_ide.php
MOS/CSG 6525 "TRI-PORT INTERFACE" - https://myoldcomputer.nl/Files/Datasheet/mos_6525_tpi.pdf
LC89515 - https://pdf1.alldatasheet.com/datasheet-pdf/view/41148/SANYO/LC89515.html
http://bitsavers.informatik.uni-stuttgart.de/components/westernDigital/_dataBooks/1993_SystemLogic_Imaging_Storage/27_WD42C22C.pdf
