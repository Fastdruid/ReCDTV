# ReCDTV
ReCDTV is an Open Hardware remake of the Commodore CDTV mainboard, revision 2.2.1

## Status

WIP. All the chips are in the correct (ish) locations with their pins all correctly on the right nets (according to the schematics) and mostly routed... I'm currently verifying they match the schematics before finishing routing. 

![image](https://github.com/user-attachments/assets/069a4b89-fae4-4c8e-8e9b-d523f96cfc27)
![image](https://github.com/user-attachments/assets/70e148a9-18ef-4b9d-a031-c0e8b96112d8)



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
6) U38 pin 8 is not connected to U63 pin 13 (this appears to be one of the fixed on Rev 2.3) - I've not yet validated what is actually connected.
7) U38 pin 1 is not connected to U63 pin 12 (this appears to be one of the fixed on Rev 2.3) - I've not yet validated what is actually connected.
8) DMAC CFGOUT is connected to ground. 
9) (Reportedly) Only one of two CPU VCC are connected! - Not verified however both are connected on this board.
10) Inverter 4 on U63 is shown on the schematics as grounded/unused. It's not. - I've not yet validated what is actually connected.
11) C88 & C89 are not listed in the parts list. C89 is repeated twice, once on page 2 and once on page 3.
12) C5 is repeated twice in the parts list. The actual capacitor fitted is a CBM P/N 900022-01 - "MLC RAD .22uF 50V"
13) The .22uF capacitors for U78 and U79 are not labled in the schematic. Presumed (due to proximity) to be C159 & C182
14) U37 is shown in the schematic as having pins 1,5 & 11 grounded. Only 11 is, Pins 2 & 6 connect to either side of JP15 which is alternately labeled JP18 on someone elses Rev 2.2.1 board! JP18/15 is not on Rev 2.1, 2.2, 2.2A, 2.2B or 2.3, not mentioned in the schematics and JP15 in them is totally different.
15) U24 pin 5 goes to U37 pin 5 instead of U17 pin 12.
16) U37 pin 6 goes to U17 pin 12 (joined to U37 pin 2 via JP15/18)
17) U24 pins 4 & 5 are grounded (minor issue as these are unused OR gates but its not shown)
18) U26 pins 3,11 & 13 are grounded (minor issue as these are unused intvertes but its not shown)
19) R48 and R49 are swapped. So U27 pin 6 goes to R49 not R48.
20) U39 Pin 1 is labeled as EPO.{CSX1} but U36 Pin 1 has it as EOP.{CSX1}
21) RP25 pin 3 is not connected to U77 pin 16 (this is signal *BUDS which is labled NC so this is not important)
22) RP25 pin 4 is not connected to U77 pin 18 (this is signal *BLDS which is labled NC so this is not important)
23) R143 is not shown in the schematic but is connected between VPP and GND

## Differences from Original

V1 is intended to be a functional "like for like" copy of a 2.2.1 board. It is not a perfect 1:1, locations have been made as close as possible but may differ slightly. I cannot guarantee anything that connects between multiple items will fit (eg the ROM developer board).

All of the non-Commodore/Amiga unique parts have been sourced as far as they can. 

Unfortunately as U62 & U75 are unique to the CDTV this isn't a project that is of much use *except* to fix a broken CDTV (that said, I did manage to buy U62 so it is at least technically possible to build a brand new one).

The routing started the same as the original however it got to a point where it just wasn't possible without removing all the components from the board to trace tracks and became increasingly difficult. 
Routing is therefore "kind of" like the original where it can be up to a certain point beyond which I treated it as a new board and just routed it as I would (based on the same rules, top layer horizontal, bottom vertical). 

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

1) T1 - The transformer for the VFD power. This is both unavailable and almost certainly impossible to remove from a board without destroying it. 
2) CN1 - The DB23 video port. Very limited availability however a servicable replica can be created from a solder cup DB23 and a "cut-n-shut" DB25.
3) CN4 - The DB23 floppy port. Very limited availability however a servicable replica can be created from a solder cup DB23 and a "cut-n-shut" DB25.
4) U17 - Sanyo LC7883M - DAC. long since replaced with newer DACs so is NLA. I will try and find a like for like replacement.
5) U16 - Mitsubishi M51568FP - Analog output amplifier. Again NLA. I will try and find a like for like replacement.

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
3) Use a CPLD to replace the massive numbers of 74 chips (as the A590 does).
4) Swap to SMD cap & resistor setup (like the A1200).
5) Use a single chip for 2MB of memory
6) Allow a 2MB 8375 Agnus to be used. 

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
