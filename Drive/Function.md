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
  
PC6 and PC7 can be used as general purpose outputs or as data transfer signals for ports A and B. I think these are used as GPIO on the basis that MS [1:0] is defined as GENLOCK MODE SELECT (AMIGA) 
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

### Subcode. 
Boy is this complicated!

We have a 4-bit ripple counter in U42 (74LS293), this is "reset" by the NAND of



R/W is handled using the normal R/W signal. The CS (Chip Select) for the Tri-Port is a NAND from A4 and CSX0 (XT Device Chip Select No.0) from DMAC

## Commanding the drive.

In the context of this section, HOST is the CDTV, Controller is the MN188161 which is an 8-bit microprocessor (on the drive) and everything is written from the perspect of the LC8951 which is the Host Bus Interface. Some commands (specifically those from U62) bypass the LC8951, these will be covered later. 

Commands to the drive are sent directly via the 8-bit parallel data bus from DMAC (SD0-7).

### To instruct the MN188161  
To tell the drive a command is to be sent *HWR is set LOW, *HRD is set HIGH and *CMD is set LOW. This instructs the LC8951 to enter command write mode. The data then sent by the host at to HD0-7 (ie from DMAC SD0-7) is then written into the LC8951 command register.  


First the ENABLE is set LOW to enable the interface.    
*CMD is set LOW to indicate a Command Write or Status Read.  
*HWR is set LOW to indicate a Host Write
*DTEN is set HIGH 
*STEN is set HIGH
Data is placed (by the host) on the 8 bidirectional data pins for a minimum of 70ns
*HWR is set high
If there is no further data then *ENABLE is set HIGH and at least 5ns later *CMD is set HIGH. 
 
The Host can send up to 8 commands by asserting the *HWR signal. 

### To read status  

First the ENABLE is set LOW to enable the interface.  
To read the drive status, *HWR is set HIGH, *HRD and *CMD is set LOW. The status previously written to the controller is then available from HD0-7 (to DMAC SD0-7) when *STEN is set LOW to signal that data is ready to be transfered. The *STEN signal goes high when the last byte is read. 
(I suspect that *HRD is also used here to indicate each byte has been read.).

### To read data

It is not clear if WAIT or DRQ is used. I suspect from the naming that DRQ is used.

To read data from the drive, *HWR is set HIGH, *HRD is set LOW and *CMD is set HIGH. This instructs the LC8951 to enter data transfer mode. Data in the (SRAM) buffer is read by the LC8951 and output to the host at HD0-7 (to DMAC SD0-7) when *DTEN is set LOW to indicate data is ready to be transfered.  
The Host reads data items one after the other by generating *HRD read pulses. If the Controller cannot keep up it will output a LOW *DRQ (WAIT) signal. The Host must not set *HRD high while *DRQ (WAIT) is low.   

First the ENABLE is set LOW to enable the interface.     
*CMD is set HIGH to indicate Data Read.  
*DTEN is set LOW to indicate Data Transfer Enable.  
*DRQ is set HIGH to indicate Data request to be read (for 
*HRD is set LOW to indicate Host Read.  
Data is placed on on the 8 bidirectional data pins for a minimum of 70ns  
*HRD is set HIGH to indicate data has been read.   
*HRD is set LOW to indicate Host Read.  
Data is placed on on the 8 bidirectional data pins for a minimum of 70ns  
If the drive cannot keep up then it sets *WAIT LOW to indicate Host Read Wait.   
Once completed *DTEN is set HIGH on the final data transfer.  
*EOP is set HIGH at the same time however this is not used on the CDTV.  
Once *HRD is HIGH then *EOP is set HIGH and then *ENABLE is set HIGH followed by *CMD also set HIGH.  

*DRQ (WAIT) is held LOW when *DTEN is high and while the LC8950 is not transferring data to the host. 

### Flow control

If the read signals from the host exceed the LC8951 maximum data rate (about 2.3MB/s), the LC8951 sets the DRQ (WAIT) pin to LOW. The host must then hold *HRD low to delay the read until the DRQ (WAIT) pin goes HIGH. 
note however that a single speed CDROM is only 150kb/s so there is little chance of getting anywhere close to this! 

### Timings

The number and figure refers to the timing diagrams... I'll try and get these drawn out!
Note that I've only put the figures for the LC8951 used in the CDTV drive rather than include the LC8950 as well. TBH the only differences are in 13 and 17
1T = XTALCK (RCHIP master clock) 1 cycle period time. 

The numbering in the datasheet is er nonsense. I will try and correct this table so that it matches the diagrams in the datasheet but some of them are a guess...

| Number | Figure | Characteristic | Min | Max | Unit |
| --- | --- | --- | --- | --- | --- |
| 1 | 38 | *ENABLE to *HWR (Host Write) Setup | 30 | - | ns |
| 2 | 38 |*CMD to HWR Setup | 15 | - | ns |
| 3 | 38 | *HWR low period | 50 | - | ns |
| 4 | 38 | *HWR to *DTEN change | - | 105 | ns |
| 5 | 38 | *HWR to *STEN change | - | 105 | ns |
| 6 | 38 | HD0-7 to *HWR inactive | 50 | - | ns |
| 7 | 38 | *HWR inactive to End of Data | 20 | - | ns |
| 8 | 38 | *HWR high period | 50 | - | ns |
| 9 | 38 | *HWR inactive to *ENABLE inactive | 0 | - | ns |
| 10 | 38 | *HWR inactive to *CMD inactive | 5 | - | ns |
| 1 | 39,40 | *ENABLE to *HRD setup | 30 | - | ns |
| 2 | 39 | *CMD to *HRD setup | 30 | - | ns |
| 3 | 39 | *DTEN to *WAIT inactive | 6T-20 (note 2) | 6T+50 | ns |
| 4 | 39 | *DTEN to *HRD setup | 0 | - | ns |
| 5 | 39 | *HRD period | 6T-50 (Note 2) | - | ns |
| 16 | 39 | *HRD low period | 6T-50 (note 4) | - | ns |
| 17 | 39 | *HRD to valid data setup with *WAIT inactive | - | No max | ns |
| 18,6 | 39,40 | *HRD to invalid data setup | 5 | 100 | ns |
| 19 | 39 | *HRD inactive to the second *WAIT inactive | 10T+180 (Note 1) | - | ns |
| 10 | 39 | *HRD high period | 50 | - | ns |
| 21 | 39 | *HRD inactive to the second *HRD active transition | 6T+180 (note 2) | - | ns |
| 22,11 | 39,40 | *HRD inactive to end of data | 5 | 60 | ns |
| 23 | 39 | *HRD inactive to end of valid data | 0 | - | ns |
| 24 | 39 | *HRD active to the next *HRD active | 6T+50 (note 2) | - | ns |
| 25 | 39 | *WAIT inactive to the next *WAIT inactive | 6T-20 (note 2) | 6T+50 | ns |
| 26 | 39 | *HRD active to *WAIT active setup | 80 | - | ns |
| 27 | 39 | *HRD active to valid data setup with *WAIT active | - (note 3) | 10T+160 | ns |
| 28 | 39 | *WAIT active period | 0 (note 3) | 10T+30 | ns |
| 29 | 39 | Valid data to *WAIT inactive | -50 | - | ns |
| 30 | 39 | *WAIT inactive to *HRD inactive | 50 | - | ns |
| 31 | 39 | *HRD active to *DTEN inactive | - | 120 | ns |
| 32,17 | 39,40 | *HRD to *EOP setup | - | 120 | ns |
| 33,13| 39,40 | *HRD inactive to *ENABLE inactive | 0 | - | ns |
| 34,14 | 39,40 | *HRD inactive to *CMD active | 5 | - | ns |
| 35,16 | 39,40 | *HRD inactive to *EOP inactive | - | 120 | ns |
| 2 | 40 | *CMD inactive to *HRD active | 15 | - | ns |
| 3 | 40 | *DTEN active to *WAIT inactive | 5 | 25 | ns |
| 7 | 40 | *WAIT period | 6T-20 | - | ns |
| 4 | 40 | *WAIT inactive to *HRD active | 0 | - | ns |
| 8 | 40 | *HRD to *WAIT setup | - | 80 | ns |
| 9 | 40 | *HRD active period | 2T | - | ns |
| 5 | 40 | *HRD to valid data setup | - | 120 | ns |
| 10 | 40 | *HRD inactive to *WAIT inactive | 2T+10 | 4T-75 | ns 
| 11 | 40 | Valid data to end of data | 0 | - | ns |
| 15 | 40 | *HRD active to *DTEN inactive | 6T-20 | - | ns |

Notes
1) Only in case *WAIT = Low occurs. If the second *HRD failing edge spens more time than these values, *WAIT = Low will not appear.
2) Minimum time tha the *WAIT = Low does NOT appear.
3) Assume *HRD two low pules and one HIGH pulse width to be 50ns.
4) *HRD is accepted in the RCHIP but the host cannot read the valid data on HD0-7 and HDR if *HRD Low pulse width is <120nsec and >50nsec.


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
https://jbum.com/cdg_revealed.html
