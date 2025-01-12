/*
This is based off the 74x based logic in the CDTV as in the A570 the XC2064 or XC2310 replaces all of that. 
Currently this merely handles the CD drive while the FPGA actually also handles the memory, ROM and NVRAM. 




*/


module a570_fpga (
    input wire IFRST_n, CCK, IOR_n, IOW_n, EFFK, SBCP, SCOR, XDACK_n, EPO_CSX1_n,
    input wire A4, CSX0_n, DRQ_n, STEN_n, GND,
    output wire CDRST_n, SCCK, XDREQ, INTD_n, HWR_n, HRD_n,
    output wire P, Q, R, S, T, U, V, W
);

    // Reset signal generation
    assign CDRST_n = ~((IOR_n | IOW_n) & IFRST_n);

    // XDREQ signal generation
    assign XDREQ = ~(~STEN_n | DRQ_n | GND);

    // HWR_n signal generation
    assign HWR_n = (A4 | CSX0_n) | IOW_n;

    // HRD_n signal generation
    assign HRD_n = ~((A4 | CSX0_n | IOR_n) & XDACK_n);

    // INTD_n signal generation
    assign INTD_n = EPO_CSX1_n | IOW_n;

    // SCCK and serial to parallel conversion
    reg [7:0] shift_reg;
    reg [2:0] pulse_counter;
    reg scck_enable;

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

    assign SCCK = scck_enable & CCK;

    always @(posedge SCCK) begin
        shift_reg <= {shift_reg[6:0], SBCP};
    end

    assign {P, Q, R, S, T, U, V, W} = shift_reg;

endmodule
