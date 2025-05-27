# ReCDTV
ReCDTV is an Open Hardware remake of the Commodore CDTV mainboard, revision 2.2.1

## Revisions
There are a number of "known" revisions of the CDTV, this is based off the 2.2.1 because that's what I have! The following lists all the revisions I "know" of. Please feel free to raise an "issue" if you know of more or have any detail about the differences! 

1) Board REV 2.1 - Known dev system, seen with piggyback U62 & U75
2) Board REV 2.2 - With fix wires marked as REV 2.2A
3) Board REV 2.2 - With fix wires marked as REV 2.2B
4) Board REV 2.2 - With fix wires marked as REV 2.3
5) Board REV 2.3 - Sticker over original silkscreen. With fewer fix wires. 
6) Board REV 2.2.1 - No fix wires.
7) Board REV 2.2.1 - Marked as REV 2.2C. No visible fix wires. Looks like an extra resistor fitted from GND to something around the top corner of U75.

## Status

Alpha. :)
Board is "complete", all components, everything routed and currently in validation phase. I'm slowly validating every chip and component on the board. Roughly 70% through validation of every IC. 

![image](https://github.com/user-attachments/assets/502022f9-04ee-4fac-bb75-5acfeada67f8)

![image](https://github.com/user-attachments/assets/f262d22c-498f-4283-8717-7846fa6e906c)




## Summary
This came about because I bought a CDTV that had been utterly destroyed by a ham fisted monkey who for unknown reasons appeared to have attempted to remove the Paula socket with a blowtorch and a chisel. 

While there are schematics out there for the CDTV I'm not aware of any remakes.

You will almost certainly need a CDTV to build this, unfortunately the drive in a CDTV is unique to it so even if you could manage to find all the parts you would be able to do anything without the drive!

I have attempted to use "new" parts where possible however some are NLA or were Commodore only parts. You will have to harvest them from an Amiga or CDTV. The most problematic is likely to be the T1 coil. This is almost certainly impossible to remove intact from the board. 

While this is based off a physical 2.2.1 board I've noted the differences between the schematics and the board and fixed or left as is depending on how appropriate it is...I should probably release updated schematics too!

## Known Schematic / Service Manual errors

There are some differences noted between the schematics/Service Manual and the actual board. These are noted here. 

1) RP1 and RP2 are the swapped/wrong way round on the schematics/board silkscreen. - Fixed (to the schematics) on this board.
2) EMI57 & EMI87 are swapped/wrong way round on the schematics/board silkscreen. - Fixed (to the schematics) on this board.
3) EMI86 isn't actually shown as being used on PRDT (just a random "EMI" shown). 
4) RP23 & RP24 don't exist on the Rev 2.2.1 board (although there appear to be locations for them).
5) It appears that the pins 6/5/4 and 8/9/10 are transposed on U23. EMC is connected to pin 9 not 5, *ROMEN is connected to 8 not 5, 6 & 5 are joined and pin 4 rather than 10 are connected to U13 pin 12 (*OE)
6) U38 pin 8 is not connected to U63 pin 13 (this appears to be one of the fixed on Rev 2.3) - connected instead to U63 pin 9. Same functionality, different gate!
7) U38 pin 1 is not connected to U63 pin 12 (this appears to be one of the fixed on Rev 2.3) - connected instead to U63 pin 8. Same functionality, different gate!
8) DMAC /CONFIGOUT is grounded.
9) DMAC /CONFIGIN is not grounded and is floating.
10) CN12 CONFIGOUT is grounded. 
11) (Reportedly) Only one of two CPU VCC are connected! - Not verified however both are connected on this re-board.
12) Inverter 4 (pin 9->10) on U63 is shown on the schematics as grounded/unused. It's not but is swapped with inverter 6 (13->12).
13) C88 & C89 are not listed in the parts list. C89 is repeated twice, once on page 2 and once on page 3.
14) C5 is repeated twice in the parts list. The actual capacitor fitted is a CBM P/N 900022-01 - "MLC RAD .22uF 50V"
15) The .22uF capacitors for U78 and U79 are not labled in the schematic. Presumed (due to proximity) to be C159 & C182
16) U37 is shown in the schematic as having pins 1,5 & 11 grounded. Only 11 is, Pins 2 & 6 connect to either side of JP15 which is alternately labeled JP18 on someone elses Rev 2.2.1 board! JP18/15 is not on Rev 2.1, 2.2, 2.2A, 2.2B or 2.3, not mentioned in the schematics and JP15 in them is totally different.
17) U24 pin 5 goes to U37 pin 5 instead of U17 pin 12.
18) U37 pin 6 goes to U17 pin 12 (joined to U37 pin 2 via JP15/18)
19) U24 pins 4 & 5 are grounded (minor issue as these are unused OR gates but its not shown)
20) U26 pins 3,11 & 13 are grounded (minor issue as these are unused inverters but its not shown)
21) R48 and R49 are swapped. So U27 pin 6 goes to R49 not R48.
22) U39 Pin 1 is labeled as EPO.{CSX1} but U36 Pin 1 has it as EOP.{CSX1}
23) RP25 pin 3 is not connected to U77 pin 16 (this is signal *BUDS which is labled NC so this is not important)
24) RP25 pin 4 is not connected to U77 pin 18 (this is signal *BLDS which is labled NC so this is not important)
25) R143 is not shown in the schematic but is connected between VPP and GND
26) D7 doesn't appear anywhere in the schematics.
27) On the Rev 2.2.1 boards Pin 19, the "MODE" pin on the LC7883 (U17) is not connected to ground...or VCC. I have no idea what (if anything) it is connected to. This is problematic as the datasheet says it should be either H or L and says nothing on if it's floating. There is a possibility that it's actually got an internal Pull Down but it is not clear. On the Rev 2.2 boards it *is* connected to gnd (obvious from photos). Also AEMP is connected to EMPH1 however if MODE is Low then EMPH1 should be "fixed to H or L". I have my suspicions that this is an undocumented feature.
28) On page 11 CDAL/AUDR is shown as going to/from page 4,5 while CDAR/AUDL is shown going to/from page 4. In reality AUDL/AUDR comes from page 4,5 and CDAR/CDAL goes to page 4
29) On page 10 U32 is shown (and listed in the spare parts list) as a 3MHz 6525B. On all CDTV's seen however a 2MHz 6525A is used.
30) On U60 pins 3 & 7 are swapped (*INCD and *CD/TV)
31) RP27 is labeled in different places with Pin 1 to VCC and pin 1 to +5VD. Its +5VD.
32) Schematic shows a 6525B while the only chip I've seen fitted in any pictures is a 6525A.
33) Pin 15 and pin 16 on CN12 are swapped. Pin 15 is /INT6, Pin 16 is A5
34) Pin 9 of U43 goes to A18 instead of GND. 


## Known issues

1) The serial->parallel shift register for the subcode is backwards so the CD+G library has to use a lookup table to reverse everything!
2) DMAC /CONFIGIN and /CONFIGOUT.... so on something like the A2000 the first /CONFIGIN on the Zorro bus is grounded, each PIC in turn will autoconfigure itself and then bring its /CONFIGOUT LOW which then sets /CONFIGIN LOW for the next PIC in turn to do the same. DMAC is setup to do this with a /CONFIGIN and a /CONFIGOUT. On the CDTV /CONFIGIN is left floating and /CONFIGOUT is shorted to ground. This is wrong in *every* way! It doesn't even work to configure external devices before DMAC (which would be wrong albeit semi-logical). The way this should be setup is /CONFIGOUT (from DMAC) is connected to the pin on the diagnostic port marked /CONFIGIN and /CONFIGIN (on DMAC) is connected to GND. /CONFIGOUT (on CN12) is then left floating as there are no more devices to configure.
   

## Differences from Original

V1 is intended to be a functional "like for like" copy of a 2.2.1 board. It is not a perfect 1:1, locations have been made as close as possible but may differ slightly. I cannot guarantee anything that connects between multiple items will fit (eg the ROM developer board).
There are however a few changes that have been made. 
1) A 5 pin connector by T1. This is because T1 is unobtainable and highly unlikely to be able to be removed from an original board. This connector therefore is to supply VF1, VPP and VF2 from +5VD using a separate board.
2) The CONFIGIN/CONFIGOUT is fixed to the diagnostic socket. Pin 6 is "/CONFIGIN" for the next device and connected to /CONFIGOUT of DMAC. DMAC has /CONFIGIN connected to GND so that it is the first device configured. /CONFIGOUT on the diagnostic socket is left floating. In case there is something reliant on the previous behaviour there are two new solder jumpers that let you revert to the incorrect behaviour! 
3) The Kickstart ROM is changed to a 42 pin. Same connectivity as A500 rev 8.
4) The duplicate JP15 is named JP18. 

All of the non-Commodore/Amiga unique parts have been sourced as far as they can. 

Unfortunately as U62 & U75 are unique to the CDTV this isn't a project that is of much use *except* to fix a broken CDTV (that said, I did manage to buy U62 so it is at least technically possible to build a brand new one).

The routing started the same as the original however it got to a point where it just wasn't possible without removing all the components from the board to trace tracks and became increasingly difficult. 
Routing is therefore "kind of" like the original where it can be up to a certain point beyond which I treated it as a new board and just routed it as I would (based on the same rules, top layer horizontal, bottom vertical). 

### Jumpers

All except unless mentioned are solder jumpers. 

* JP1) Normally Open. Connects /EXRAM to ground.
* JP2) N/A
* JP3) Double Jumper. Normally connects /INT2 to DMAC. Can instead connect /INT6.
* JP4) Double Jumper. Normally connects A19 (pin 59) from Agnus to A19. Can instead connect A23.
* JP5) Normally closed. Selects 
* JP6) Double Jumper. Normally connects BRW to pin 21 of a 24 pin U78 but can connect A12 to pin 23 (same physical pin, just number shifted) if a 28 pin SRAM chip is fitted. 
* JP7) Double Jumper. Normally connects BRW to pin 21 of a 24 pin U79 but can connect A12 to pin 23 (same physical pin, just number shifted) if a 28 pin SRAM chip is fitted.
* JP8) Double jumper. Connects NTSC or PAL crystal to Agnes. 
* JP9) Normally open on PAL machines. Selects NTSC/PAL power for PAL crystal.
* JP10) Normally closed on PAL machines. Selects NTSC/PAL for NTSC crystal.
* JP11) Normally open on PAL machines. Selects NTSC/PAL for Agnes. 
* JP12) N/A
* JP13) Normally closed. Connects C16M from the drive to the DAC. 
* JP14) Double jumper. Both normally closed. Connects audio to the headphone socket.
* JP15) Double pin jumper. Direction doesn't matter. Connects /CSCD and enables the CDTV functionality. 
* JP15/JP18) Normally closed. Connects INITB on U17 to U37. 
* JP16) Normally open. Connects A18 to pin 39 of CN13
* JP17) Normally open. Connects A19 to pin 40 of CN13
* JP19) Normally closed. Connects DMAC /CONFIGIN to ground. Cut to revert to original behaviour (DMAC /CONFIGOUT floating). 
* JP20) Four way jumper. Connects pins 2-3 which is DMAC /CONFIGOUT to CN12 CONFIGIN. Solder across all 4 pins to revert to original behaviour. 

## Commodore chips required.

1) U62 - CSG 252609-22 (basically the same as an A500 keyboard controller but with a different ROM/firmware).
2) U75 - CSG 252608-01 (Sanyo LC6555H-4615 with custom ROM/firmware)
3) U36 - "DMAC" CSG 390563-02
4) U32 - "Tri-Port" CSG 6525A (Note the speed rating)
5) U44 - "Fat Agnus" CSG 318069-02 (8372A)
6) U8  - "Denise" CSG 8362R8
7) U9/U10 - "CIA" CSG 8520A-1 (obviously 2x)
8) U4 - "Paula" CSG 252127-02
9) U12 - "Gary" CSG 5719

## Unobtainium (non Commodore) parts.

This will list "regular" parts that are NLA. 

1) T1 - The transformer for the VFD power. This is both unavailable and almost certainly impossible to remove from a board without destroying it hence why there is a 5 pin connector to supply the required voltages. 
2) CN1 - The DB23 video port. Very limited availability however a servicable replica can be created from a solder cup DB23 and a "cut-n-shut" DB25.
3) CN4 - The DB23 floppy port. Very limited availability however a servicable replica can be created from a solder cup DB23 and a "cut-n-shut" DB25.
4) U17 - Sanyo LC7883M - DAC. long since replaced with newer DACs so is NLA. While I have tried to find a like for like replacement EIAJ DACs are NLA and the CDTV makes use of the "volume" on the LC7883M to mute/fade under software control. These are *sometimes* seen on aliexpress (I've managed to buy two).
5) U16 - Mitsubishi M51568FP - Analog output amplifier. Again NLA. I have not found a replacement but these do again turn up occasionally. I managed to pick one up from ebay. 

### Connectors
#### CN26, CN17B, CN18 - 3 way
Molex 530140310 (53014-0310) - Available still on Aliexpress
#### CN23, CN24, CN19 - 2 way
Molex 530140210 (53014-0210) - Available still on Aliexpress
#### CN27 - 4 way
Molex 530140410 (53014-0410) - Available still on Aliexpress
#### CD Drive (3 way horizontal)
Molex 530150310 (53015-0310) - Available still on Aliexpress

#### Connectors
2-way 510040200, 3-way 510040300 & 4-way 510040400, they use Molex 50011 crimp terminals, these appear to still be available (50011-8000)

## Considered improvements.

1) Swap to SMD versions of all 74 chips.
2) Remove U28 and use the other "half" of U24 instead.
3) Use a CPLD to replace the massive numbers of 74 chips (as the A570 does).
4) Swap to SMD cap & resistor setup (like the A1200).
5) Use a single chip for 2MB of memory
6) Allow a 2MB 8375 Agnus to be used. 
7) Add Fast RAM expansion using DMAC functionality (as the A570 does).
8) Use a single ROM for the CDTV OS. 

## Other things of note. 

TBC

## Manufacture

The board is a 4 layer board utilising 0.127mm / 5 mil traces. 

## Assembly

Haha. 

## Releases

TBC

## Thanks

- SukkoPera, JasonsBeer, John "Chucky" Hertell and any others that have created or contributed to open-sourced Amiga designs. They have been invaluable for a bunch of stuff.
- Commodore - For making a cool machine that was massively before its time!
- [Amiga PCB Explorer](http://amigapcb.org) - A massively useful tool to follow original boards.
- [amigawiki](https://www.amigawiki.org/doku.php?id=en:service:schematics) - Not so much for CDTV but useful for the other schematics
- [CDTV LAND](https://cdtvland.com/) - Heaps of CDTV information.
