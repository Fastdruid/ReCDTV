# Commodore CDTV CDROM Drive functionality

This is mostly my notes on how the CDTV CDROM drive works. While fundamentally the same for the A570, the chips are moved around somewhat and an FPGA (technically I think a CPLD) replaces the 74 based logic of the CDTV. On the A570 the Host interface is moved from the drive to the controller and as a result the cable pinout is quite different. 

## CDTV Side

The CDTV uses a DMAC (390563-02) to generate an 8-bit IBM PC XT(A) (Not ST-506) interface (see below) the 8-bit data bus is is connected to the Tri-Port (6525A [225ns]) which is in Mode 1 (Interupt Mode), in this mode there are 16 I/O lines, 2 handshake lines and 5 interrupt lines. 

The interrupt lines are as follows:
PC0  
PC1 (SCOR)  
PC2 (STCH)  
PC3 (STEN)  
PC4 (DRQ)  
PC5 is the IRQ output and drives IRQ2  
  
PC6 and PC7 can be used as general purpose outputs or as data transfer signals for ports A and B. I think these are used as GPIO on the basis that MS [1:0] is defined as GENLOCK MODE SELECT (AMIGA), these are then fed to the 
PC6 (MS0) - GENLOCK MODE SELECT  (to U62)
PC7 (MS1) - GENLOCK MODE SELECT  (to U62)

Then we have a number of command lines. 
PB0 CMD (to the drive)
PB1 ENABLE (to the drive)
PB2 XAEN (to the drive)
PB3 DTEN (to the drive)
PB4 WEPPROM (to CN29)
PB5 DACATT (to the DAC, U17)
PB6 DACST (to the DAC, U17)
PB7 DACLCH (to the DAC, U17)

Finally we have PA0-PA7, this takes EFM Encoded Subcode data via a serial to parallel converter using a 74LS74 (U28),  74LS164 (U31), 74LS292 (U42) (as well as a number of gates from a 74LS08 (U21), 74LS00 (U29), 74LS04 (U40), and 74LS02 (U30)) and splits it to Channels W through P. 

R/W is handled using the normal R/W signal. The CS (Chip Select) for the Tri-Port is a NAND from A4 and CSX0 (XT Device Chip Select No.0) from DMAC

## Commanding the drive.

In the context of this section, HOST is the CDTV, Controller is the MN188161 which is an 8-bit microprocessor (on the drive) and everything is written from the perspect of the LC8951 which is the Host Bus Interface. Some commands (specifically those from U62) bypass the LC8951, these will be covered later. 

Commands to the drive are sent directly via the 8-bit parallel data bus from DMAC (SD0-7).

### To instruct the MN188161  

First the ENABLE is set LOW to enable the interface.  
To tell the drive a command is to be sent *HWR is set LOW, *HRD is set HIGH and *CMD is set LOW. This instructs the LC8951 to enter command write mode. The data then sent by the host at to HD0-7 (ie from DMAC SD0-7) is then written into the LC8951 command register. 

### To read status  

First the ENABLE is set LOW to enable the interface.  
To read the drive status, *HWR is set HIGH, *HRD and *CMD is set LOW. The status previously written to the controller is then available from HD0-7 (to DMAC SD0-7) when *STEN is set LOW to signal that data is ready to be transfered. 

### To read data

First the ENABLE is set LOW to enable the interface.  
To read data from the drive, *HWR is set HIGH, *HRD is set LOW and *CMD is set HIGH. This instructs the LC8951 to enter data transfer mode. Data in the (SRAM) buffer is read by the LC8951 and output to the host at HD0-7 (to DMAC SD0-7) when *DTEN is set LOW to indicate data is ready to be transfered.
*DRQ (WAIT) is held LOW when *DTEN is high and while the LC8950 is not transferring data to the host. 

### Flow control

If the read signals from the host exceed the LC8951 maximum data rate (about 2.3MB/s), the LC8951 sets the DRQ (WAIT) pin to LOW. The host must then hold *HRD low to delay the read until the DRQ (WAIT) pin goes HIGH. 

## Subcode. 

Oooh, this is nasty. So 4 pins transfer the subcode via a serial to parallel converter into DMAC.

As I understand it the EFFK "clock" AND !SCOR "sync output) combine with CCK in U28, that then feeds via another clock which generates SSCK which feeds into the drive. The SSCK clock along with the SBCP (actual subchannel data) is then fed into U31 which converts from serial to parallel and feeds into the Tri-Port (and from there to DMAC). 

## XT Interface 


XTA (XT-IDE) Interface Pinouts

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
