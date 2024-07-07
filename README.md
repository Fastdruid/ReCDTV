# ReCDTV
ReCDTV is an Open Hardware remake of the Commodore CDTV mainboard, revision 2.2.1/2.3

## Status

WIP. Almost all the chips are in the correct (ish) locations with their pins all correctly on the right nets.

## Summary
This came about because I bought a CDTV that had been utterly destroyed by a ham fisted monkey who for unknown reasons appeared to have attempted to remove the Paula socket with a blowtorch and a chisel. 

While there are schematics out there for the CDTV I'm not aware of any remakes.

You will almost certainly need a CDTV to build this, unfortunately the drive in a CDTV is unique to it so even if you could manage to find all the parts you would be able to do anything without the drive!

I have attempted to use "new" parts where possible however some are NLA or were Commodore only parts. You will have to harvest them from an Amiga or CDTV.

While this is based off a physical 2.2.1 board I've noted the differences between the schematics and the board and as so applied these. 

## Known Schematic errors

There are some differences noted between the schematics and the actual board. These are noted here. 

1) RP1 and RP2 are the wrong way round on the schematics/board. - Fixed on this board. 
2) RP23 & RP24 don't exist on the Rev 2.2.1 board (although there appear to be locations for them).
3) U23 pins 8, 9 & 4 aren't connected (this appears to be one of the fixes on Rev 2.3)
4) U23 pin 5 is not connected to U43 or U81 (this appears to be one of the fixes on Rev 2.3)
5) U23 pin 4 is connected to U13 pin 12 (*OE) not pin 10
6) U12 (Gary) Pin 21 (*ROMEN) is connected to pin 9 on U23 (and ground to pin 8) while the schematic shows it as being connected to Pin 6
7) U38 pin 8 is not connected to U63 pin 13 (this appears to be one of the fixed on Rev 2.3) - I've not yet validated what is actually connected.
8) U38 pin 1 is not connected to U63 pin 12 (this appears to be one of the fixed on Rev 2.3) - I've not yet validated what is actually connected.

## Differences from Original

V1 is intended to be a functional "like for like" copy of a 2.2.1 board *WITH* the changes made to the 2.2 board to become rev 2.3. It is not a perfect 1:1 locations have been made as close as possible but may differ slightly. 

All of the non-Commodore/Amiga unique parts have been sourced as far as they can. 

Unfortunately as a number of the chips are unique to the CDTV this isn't a project that is of much use *except* to fix a broken CDTV. 

The routing is "kind of" like the original however while I have tried to follow the routing I have focused on functionality over being identical. 

## Unobtainium (non Commodore) parts.

TBC - This will list "regular" parts that are NLA. 

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
