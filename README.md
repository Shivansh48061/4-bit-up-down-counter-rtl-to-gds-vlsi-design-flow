# 4-bit-up-down-counter-rtl-to-gds-vlsi-design-flow
This project implements a 4-bit up/down counter through the complete RTL to GDSII VLSI design flow. The design is written in Verilog, functionally verified, synthesized with timing constraints, and physically implemented through floorplanning, placement, CTS, routing, and sign-off to generate a final GDSII layout.

# Tools Used
Cadence Simulator (Waveform generation)
Cadence Genus ( Generating a gatelevel netlist)
Cadence Innovus ( Physical Design )
Cadence Virtuoso ( Viewing of GDS File)
Verilog HDL (Language used for RTL implementation)

## Working and Verilog Code
  When UP = 1, the counter increments on every clock pulse.
  When UP = 0, the counter decrements on every clock pulse.
  When RESET = 1, the counter resets to 0000.

  // 4-bit Up-Down Counter Module
// Counts up when we = 1
// Counts down when we = 0
// Resets to 0 when rst = 1

module counter(
    input clk,          // Clock input
    input rst,          // Reset input (active high)
    input we,           // Write enable: 1 = count up, 0 = count down
    output reg [3:0] COUNT   // 4-bit counter output
);

// Always block triggered on rising edge of clock
always @(posedge clk)
begin
    if (rst)
        COUNT <= 4'b0000;        // Reset counter to 0
    else if (we)
        COUNT <= COUNT + 1;     // Increment counter when we = 1
    else
        COUNT <= COUNT - 1;     // Decrement counter when we = 0
end

endmodule


# Verilog Testbench

// Testbench for 4-bit Up-Down Counter

module counter_tb();

    reg clk;            // Clock signal
    reg rst;            // Reset signal
    reg we;             // Write enable (1 = up, 0 = down)
    wire [3:0] COUNT;   // Counter output

    // Instantiate the counter module (Unit Under Test)
    counter uut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .COUNT(COUNT)
    );

    // Clock generation: 10 time unit period (toggle every 5 units)
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial
    begin
        rst = 1'b1;     // Apply reset
        #10;

        we = 1'b0;     // Set counter to down mode
        #10;

        rst = 1'b0;    // Release reset, start counting up
        we = 1'b1;
        #10;

        rst = 1'b0;    // Continue counting up
        we = 1'b1;
        #10;

        rst = 1'b0;    // Continue counting up
        we = 1'b1;
        #10;

        rst = 1'b0;    // Switch to down counting
        we = 1'b0;
        #10;

        rst = 1'b0;    // Continue counting down
        we = 1'b0;
        #10;

## Cadence Genus Output Implementation
# Set standard cell library search path
set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib/

# Read the slow corner standard cell library
read_libs slow.lib

# Read RTL design file
read_hdl counter.v

# Elaborate the design
elaborate

# Create clock constraint
# Clock name: clk
# Period: 10 ns (100 MHz)
# Rising edge at 0 ns, falling edge at 5 ns
create_clock -name clk -period 10 -waveform {0 5} [get_ports "clk"]

# Run generic synthesis
syn_generic

# Map design to standard cell library
syn_map

# Optimize design for timing, area, and power
syn_opt

# Generate reports
report_gates_power     ;# Report total gate count and power consumption
report_area            ;# Report design area
report_timing          ;# Report timing analysis

# Write synthesized netlist
write_netlist > counter_nl.v

# Write timing constraints file
write_sdc > counter_sdc.sdc


## AUTHOR
Shivansh Mohan
B.Tech Electronics and Communication Engineering
