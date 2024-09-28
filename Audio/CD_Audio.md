# CDTV CD Audio

This is an attempt to understand the CD Audio on the CDTV

## DAC

The DAC used is a Sanyo LC7883M (U17), digital audio from the CD drive in I2S format (BCLK,DATA & LRCLK) is convered to analog audio. A TL082 (U18) is used as a buffer before the audio is amplified.
Attenuation and de-emphasis is controlled via an SPI interface which is connected to the TriPort.
It is not clear why but AEMP from the CD drive is connected to EMPH1. This should have no functionality as the LC7883 is "serial data transfer mode" controlled. I'm unsure if this has no effect or there is some undocumented functionality here. 

A Low Pass Filter is recommended by Sanyo however as the M51568FP contains one there is no separate LPF.

## Amplifier

The amplifier used is a M51568FP, this contains three amplifiers, a LPF AMP, a De-emphasis AMP and a Headphone AMP

The headphone output gives 13mW typ
