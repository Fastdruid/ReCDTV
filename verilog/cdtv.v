/*
This is based off the 74x based logic in the CDTV. Intention is to remove a *vast* number of "74xxx" chips.

Intended to be used on something 5 Volt suitable... choice is limited these days but I will test on a ATF1508 in a Zorro II card. 
Note that some of these signals can actually stay "within" the chip and may be stripped out later. 


*/


module cdtv (
     
     // Address lines for decoding.
     input wire A4, // Address line A4
     input wire A14, // Address line A14
     input wire A15, // Address line A15
     input wire A16, // Address line A16
     input wire A17, // Address line A17
     input wire A18, // Address line A18
     input wire A19, // Address line A19
     input wire A20, // Address line A20
     input wire A21, // Address line A21
     input wire A22, // Address line A22
     input wire A23, // Address line A23

     // Amiga signals
     input wire LDS_n,  // Lower Data Strobe
     input wire UDS_n,  // Upper Data Strobe
     input wire AS, // Address strobe
     // input wire CCK, // Colour Clock (aka C1) - Not available on the Zorro bus.
     input wire CCK_n, // Inverse CCK
     input wire CCKQ_n, // Colour Clock Quadrature aka C3
     input wire CDAC // 7MHz Quatrature Clock
    
     // CDROM lines
     input wire STCH_n, // Status Change signal
     output wire STCH, // Status Change signal (inverted)
     input wire SBCP, // Serial Subchannel
     output wire SCCK, // Serial subchannel data clock.
     input wire STEN_n, // STatus ENable
     output wire CDRST_n, // Reset CD-ROM
     output wire HWR_n, // Host Write Request
     output wire HRD_n, // Host Read Request
     input wire DRQ, // Device Ready Queue
     input wire EFFK, // CDROM clock
     input wire SCOR, // CDROM Sync
     output wire SCOR_n, // CDROM Sync (inverted)

     // CD-ROM Subchannels
     output wire P,
     output wire Q,
     output wire R,
     output wire S,
     output wire T,
     output wire U,
     output wire V,
     output wire W,

  
     //DMAC stuff
     input wire CSX0_n,  // XT Device Chip Select 0
     input wire CSX1_n,  // XT Device Chip Select 1
     input wire IOR_n,   // DMAC IO Read
     input wire IOW_n,   // DMAC IO Write
     input wire XDACK_n, // XT Device Data Acknowledge
     output wire XDREQ, // XT Device Data Requirement

     // Chip select
     output wire CSMC_n,  // Chip Select Memory Card
     output wire CSMCEN_n, // Chip Select Memory Card Even
     output wire CSMCOD_n, // Chip Select Memory Card Odd
     output wire CSCD_n,  // CHIP Select CDROM Driver
     output wire CSOD_n,  // Chip Select CDROM Driver Odd
     output wire CSEN_n,  // Chip Select CDROM Driver Even
     output wire CSRC_n,  // Real Time Chip Select
     output wire CSNV_n,  // Chip Select Non-Volatile Memory Select
     output wire EMC, // Enable Memory Card
     output wire ECD, // Enable CDROM Driver (ROM)
   
 
     // Other signals
     input wire IFRST_n, // Interface reset. 
     input wire AUPLY_n, // CD Audio play
     input wire INTD_n, // CD Drive Reset
     input wire IFRST_n, // Interface Reset
     output wire INITB, // Initialise DAC
     output wire DTACK_n, // Data Transfer Acknowledge
  
  
);


    // This depends on if we're in a Zorro slot or a CDTV. Hash out (and unhash the input) if you have a really real CCK.
    assign CCK = ~CCK_n;

    /*
    This replaces:
    U49 (3-to-8 line decoder/demultiplexer, inverting outputs)
    U50 (3-to-8 line decoder/demultiplexer, inverting outputs)
    */

    assign CSMC_n = ~(A23 & A22 & A21 & ~A20);  // Generate CMSC_n, Range 0xE00000 to 0xEFFFFF - for Memory Card.
    assign CSCD_n = ~(A23 & A22 & A21 & A20);  // Genarate CSCD_n, Range 0xF00000 to 0xFFFFFF - for CD
    assign CSNV_n = ~((A23 & A22 & ~A21 A20 ) & A19 & A18 & ~A17 & ~A16 & A15 & ~A14); // Generate CMNV_n, Range 0xDC8000 to 0xDCBFFF - for NVRAM
    assign CSRC_n = ~((A23 & A22 & ~A21 A20 ) & A19 & A18 & ~A17 & ~A16 & ~A15);       // Generate CMRC_n, Range 0xDC0000 to 0xDC7FFF - for RTC
    
    /* 
    This replaces
    U43 (Triple 3-input positive-NOR gates) - 2/3 gates
    U23 (quad 2-input NOR gate) - 2/4 gates
    U81 (quad 2-input NAND gate) 4/4 gates (all gates replaced)
    */
    assign EMC = ~(A19 | CSMC_n); // Generate EMC - U43
    assign ECD = ~(A19 | CSCD_n); // Generate ECD - U43
    assign AUDS_n = ~{UDS_n | AS_n); // U23
    assign ALDS_n = ~{LDS_n | AS_n); // U23
    assign CSMCEN_n = ~(EMC & AUDS); // U81                     
    assign CSMCOD_n = ~(EMC & ALDS); // U81
    assign CSEN_n = ~(ECD & AUDS); // U81                     
    assign CSOD_n = ~(ECD & ALDS); // U81


    /*
    This replaces: 
    U73 (quad 2-input OR gate) - 1/4 gates
    U29 (quad 2-input NAND gate) - 1/4 gates
    U30 (quad 2-input NOR gate) - 1/4 gates
    */
    assign CDRST_n = ~((IOR_n | IOW_n) & IFRST_n);     // Reset signal generation

    /*
    This replaces: 
    U26 (hex inverter gate) - 1/6 gates
    U40 (hex inverter gate) - 1/6 gates
    U41 (Triple 3-input positive-NOR gates) - 1/3 gates
    */
    assign XDREQ = ~(~STEN_n | DRQ_n | GND); // XDREQ signal generation

    /*
    This replaces:
    U39 (quad 2-input OR gate) - 2/4 gates
    */
    assign HWR_n = (A4 | CSX0_n) | IOW_n;     // HWR_n signal generation

    
    /*
    This replaces:
    U30 (quad 2-input NOR gate) - 1/4 gates
    U29 (quad 2-input NAND gate) - 1/4 gates
    U39 (quad 2-input OR gate) 2/4 gates (one gate shared with HWR_n)
    */
    assign HRD_n = ~((A4 | CSX0_n | IOR_n) & XDACK_n); // HRD_n signal generation

    /*
    This replaces:
    U39 (quad 2-input OR gate) 1/4 gates (All gates now replaced)
    */
    assign INTD_n = EPO_CSX1_n | IOW_n; // INTD_n signal generation

    /*
    This replaces:
    U40 (hex inverter gate) - 1/6 gates
    */
    assign SCOR_n = ~SCOR; // SCOR_n signal generation. 

    /*
    This replaces:
    U26 (hex inverter gate) - 1/6 gates
    U22 (quad 2-input OR gate) - 1/4 gates
    Note that U22 is used for CIA selection (as it does in an A500 as well) so this leaves 2 gates "in use". 
    */
    assign U32_CS = ~A4 | CSX0_n; 
  
    /*
    This replacea
    U63 (hex inverter gate) - 3/6 gates
    U38 (quad 2-input NAND gate) - 4/4 gates
    It doesn't replace U37 as that remains as a buffer.
    */
 
    assign DTACK_n = ~((~(((~CCK_n) & (~CCKQ_n)) & ~CDAC)) & EMC);


    /*
    This replaces:
    U26 (hex inverter gate) - 1/6 gates
    */

    assign STCH = ~STCH_nl // STCH signal generation.

    /*
    This replaces:
    U21 (quad 2-input AND gate) - 2/4 gates
    U28 (dual D positive edge triggered flip-flop, asynchronous preset and clear) - 1/2 (second is unused)
    U29 (quad 2-input NAND gate) - 3/4 gates (All gates now replaced)
    U39 (quad 2-input OR gate) - 1/4 gates
    U40 (hex inverter gate) - 2/6 gates
    U31 (8-bit parallel-in serial-out (PISO) shift register, parallel load, complementary outputs) 
    U42 (4-bit binary counter (separate divide-by-2 and divide-by-8 sections)) 
    */
  
    // SCCK and serial to parallel conversion
    reg [7:0] shift_reg;
    reg [2:0] pulse_counter;
    reg scck_enable;

    // Generate the SCCK clock based off CCK triggered by 
    always @(posedge CCK or posedge EFFK) begin
        if (EFFK) begin
            pulse_counter <= 3'b000;
            scck_enable <= 1'b1;
        end else if (scck_enable) begin
            if (pulse_counter == 3'b111) begin
                scck_enable <= 1'b0;
            end else begin
                pulse_counter <= pulse_counter + 1'b1;
            end
        end
    end

    assign SCCK = scck_enable & CCK; // Generate SCCK

        always @(posedge SCCK) begin
        shift_reg <= {shift_reg[6:0], SBCP};
    end

    assign {P, Q, R, S, T, U, V, W} = shift_reg;

endmodule
