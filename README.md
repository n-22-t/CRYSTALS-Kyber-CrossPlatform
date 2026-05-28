# CRYSTALS-Kyber Cross-Platform FPGA Implementation

Cross-platform FPGA implementation of CRYSTALS-Kyber (ML-KEM, FIPS 203)
targeting Xilinx Artix-7 and Intel Cyclone V.

Developed as part of an MSc thesis in Cybersecurity and Cryptology
at the National Higher Polytechnic Institute, University of Bamenda.

**Author:** NAMBOALU TINA NKENGANYI

## Platforms

| Platform | Device | Tool | Fmax | Resources |
|---|---|---|---|---|
| Xilinx Artix-7 | xc7a100tcsg324-1 | Vivado 2025.2 | 153.8 MHz | 7,346 LUTs · 2 DSPs |
| Intel Cyclone V | 5CGXFC7C7F23C8 | Quartus Prime Lite 23.1 | 134.3 MHz | 3,938 ALMs · 0 DSPs |

## Features

- Complete CCA-secure Kyber KEM: KeyGen, Encapsulation, Decapsulation
- All three parameter sets at runtime: Kyber512 (k=2), Kyber768 (k=3), Kyber1024 (k=4)
- Verified against NIST KAT count=0 test vectors for all three parameter sets
- Cross-platform porting via behavioural Verilog IP wrappers with no RTL changes

## Performance Results

| Operation | Kyber512 | Kyber768 | Kyber1024 |
|---|---|---|---|
| KeyGen (Artix-7) | 22.1 μs | 36.9 μs | 55.3 μs |
| Encaps (Artix-7) | 55.1 μs | 88.4 μs | 128.8 μs |
| Decaps (Artix-7) | 102.8 μs | 159.2 μs | 226.3 μs |
| KeyGen (Cyclone V) | 25.3 μs | 42.3 μs | 63.4 μs |
| Encaps (Cyclone V) | 63.1 μs | 101.2 μs | 147.5 μs |
| Decaps (Cyclone V) | 117.7 μs | 182.4 μs | 259.2 μs |

## Porting to Intel Cyclone V

The file `quartus_wrappers.v` replaces five Xilinx-specific IP cores
with behavioural Verilog equivalents compatible with Quartus Prime:

| Xilinx IP Core | Function | Replacement |
|---|---|---|
| blk_mem_gen | Polynomial coefficient storage | Synchronous dual-port BRAM |
| dist_mem_gen | Twiddle factor ROM | Async-read synchronous-write ROM |
| c_shift_ram | Pipeline delay elements | Behavioural delay line |
| fifo_generator | Data buffering | Circular buffer |
| mult_gen_0 | NTT butterfly multiplier | Signed multiply expression |

One additional RTL change: hash core reset sensitivity changed from
negedge to posedge to match Cyclone V active-high reset convention.
All other RTL files are identical between the two platforms.

## Verification

All three parameter sets verified against NIST KAT count=0 test vectors
using Vivado 2025.2 behavioural simulation. Shared secrets match
reference values for KeyGen, Encapsulation, and Decapsulation.

## How to Use

**Artix-7 (Vivado):**
1. Create a new Vivado project targeting xc7a100tcsg324-1
2. Add all .v and .vhd files as sources
3. Add kyber_top.xdc as constraint
4. Run simulation with kyber_tb.v to verify KAT

**Cyclone V (Quartus):**
1. Create a new Quartus project targeting 5CGXFC7C7F23C8
2. Add quartus_wrappers.v as the FIRST source file
3. Add all remaining .v and .vhd files
4. Add kyber.sdc as timing constraint
5. Run compilation

## Based On

Xing, Y. and Li, S. (2021). A Compact Hardware Implementation of
CCA-Secure Key Exchange Mechanism CRYSTALS-KYBER on FPGA.
IACR Transactions on Cryptographic Hardware and Embedded Systems.
(https://github.com/xingyf14/CRYSTALS-Kyber)

## License

MIT License — Copyright (c) 2025 NAMBOALU TINA NKENGANYI
