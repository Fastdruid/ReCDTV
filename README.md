# ReCDTV
ReCDTV is an Open Hardware remake of the Commodore CDTV mainboard, revision 2.2.1/2.3

## Status

WIP. Almost all the chips are in the correct (ish) locations with their pins all correctly on the right nets (according to the schematics).
![image](https://github.com/user-attachments/assets/ca93b779-4152-4e24-b5c8-5961822639a0)



## Summary
This came about because I bought a CDTV that had been utterly destroyed by a ham fisted monkey who for unknown reasons appeared to have attempted to remove the Paula socket with a blowtorch and a chisel. 

While there are schematics out there for the CDTV I'm not aware of any remakes.

You will almost certainly need a CDTV to build this, unfortunately the drive in a CDTV is unique to it so even if you could manage to find all the parts you would be able to do anything without the drive!

I have attempted to use "new" parts where possible however some are NLA or were Commodore only parts. You will have to harvest them from an Amiga or CDTV.

While this is based off a physical 2.2.1 board I've noted the differences between the schematics and the board and as so applied these. 

## Known Schematic errors

There are some differences noted between the schematics and the actual board. These are noted here. 

1) RP1 and RP2 are the swapped/wrong way round on the schematics/board silkscreen. - Fixed (to the schematics) on this board.
2) EMI57 & EMI87 are swapped/wrong way round on the schematics/board silkscreen. - Fixed (to the schematics) on this board.
3) EMI86 isn't actually shown as being used on PRDT (just a random "EMI" shown). 
4) RP23 & RP24 don't exist on the Rev 2.2.1 board (although there appear to be locations for them).
5) U23 pins 8, 9 & 4 aren't connected (this appears to be one of the fixes on Rev 2.3)
6) U23 pin 5 is not connected to U43 or U81 (this appears to be one of the fixes on Rev 2.3)
7) U23 pin 4 is connected to U13 pin 12 (*OE) not pin 10
8) U12 (Gary) Pin 21 (*ROMEN) is connected to pin 9 on U23 (and ground to pin 8) while the schematic shows it as being connected to Pin 6
9) U38 pin 8 is not connected to U63 pin 13 (this appears to be one of the fixed on Rev 2.3) - I've not yet validated what is actually connected.
10) U38 pin 1 is not connected to U63 pin 12 (this appears to be one of the fixed on Rev 2.3) - I've not yet validated what is actually connected.
11) DMAC CFGOUT is connected to ground. 
12) (Reportedly) Only one of two CPU VCC are connected! - Not verified however both are connected on this board.
13) Inverter 4 on U63 is shown on the schematics as grounded/unused. It's not. - I've not yet validated what is actually connected.

## Differences from Original

V1 is intended to be a functional "like for like" copy of a 2.2.1 board *WITH* the changes made to the 2.2 board to become rev 2.3. It is not a perfect 1:1 locations have been made as close as possible but may differ slightly. 

All of the non-Commodore/Amiga unique parts have been sourced as far as they can. 

Unfortunately as a number of the chips are unique to the CDTV this isn't a project that is of much use *except* to fix a broken CDTV. 

The routing is "kind of" like the original however while I have tried to follow the routing I have focused on functionality over being totally identical. 

## Unobtainium (non Commodore) parts.

TBC - This will list "regular" parts that are NLA. 

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
