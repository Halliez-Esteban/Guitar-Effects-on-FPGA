# Custom Real-Time FPGA Audio Multi-Effects Processor

A high-performance, zero-latency digital signal processing (DSP) system implemented entirely from scratch in **100% VHDL** on FPGA. This project processes real-time guitar and vocal signals through a modular, hardware-accelerated pipeline without relying on third-party DSP IPs. The whole project has been made for and tested on the Terasic DE2-115 FPGA Development and Education Kit.

## Technical Architecture & DSP Pipeline

Unlike software-based solutions (MCU/DSP), this architecture leverages hardware parallelism to execute all audio processing blocks concurrently with deterministic, sub-millisecond latency.

```text
[ Analog In ] ──> [ Audio CODEC A/D ] ──> [ Custom I2S Receiver ]
                                                  │
                                                  ▼
                         ┌────────────────────────────────────────┐
                         │   100% Custom VHDL DSP Pipeline        │
                         │                                        │
                         │  [ Preamp & Gain Control ]             │
                         │            │                           │
                         │  [ Bitcrusher & Hard/Soft Clipping ]   │
                         │            │                           │
                         │  [ Octaver (Pitch Division) ]          │
                         │            │                           │
                         │  [ Custom FIR Filter & Auto-Wah ]      │
                         │            │                           │
                         │  [ Tremolo (DDS LFO Modulator) ]       │
                         │            │                           │
                         │  [ Chorus (Modulated Delay Line) ]     │
                         │            │                           │
                         │  [ Delay (BRAM Circular Buffer) ]      │
                         └────────────────────────────────────────┘
                                                  │
                                                  ▼
[ Analog Out ] <── [ Audio CODEC D/A ] <── [ Custom I2S Transmitter ]
```

### Complete Audio Effects Suite (Production Ready)

All modules were designed at the Register-Transfer Level (RTL) using fixed-point arithmetic:

~ Distortion: Custom hard and soft clipping mathematical functions with configurable drive/gain stages.

~ Bitcrusher: Dynamic resolution reduction (bit-masking) and variable sample-rate reduction.

~ FIR Filter: Custom-designed Finite Impulse Response filter architecture using DSP48 slices for frequency shaping.

~ Auto-Wah: Envelope-controlled filtering combining signal envelope detection with dynamic active bandpass manipulation.

~ Octaver (WIP) : Sub-harmonic generator based on zero-crossing detection and frequency division logic.

~ Tremolo: Amplitude modulation driven by a custom Direct Digital Synthesizer (DDS) Low-Frequency Oscillator.

~ Chorus: Short modulated delay line utilizing LFO sweeps to add spatial depth.

~ Delay / Echo: Configurable feedback delay using circular buffers mapped directly onto internal Block RAM (BRAM).

#### Experimental Vocal DSP Research (WIP / Research)

Additional modules developed to evaluate vocal processing constraints on FPGA fabric:

~ Vocoder & Formant Shifter: Prototyped using custom filter banks and pitch-tracking algorithms. Highlighted hardware trade-offs between latency, BRAM memory bandwidth, and DSP slice utilization.

~ Vocal Octaver: Benchmarked pitch-tracking stability on monophonic instrument signals versus complex vocal formants.

Note: Source files and behavioral testbenches remain accessible in the repository for benchmarking and future optimizations.

##### Repository Structure

```Plaintext
├── VHDL/                # 100% Custom VHDL Source Files
└── Testbenches/        # .wav audio files with and without effect
└── Docs/               # Useful documentation
```

###### Core Engineering Competencies

100% Custom RTL Design & Synthesis: Designed the entire architecture from scratch in VHDL. Optimized resource consumption across LUTs, DSP slices (multipliers), and BRAM blocks.

Digital Signal Processing (DSP): Fixed-point arithmetic pipelines, FIR filter design, envelope tracking, DDS LFOs, and delay-line architectures.

Verification & Debugging: Behavioral simulation with ModelSim using real WAV audio files as input test vectors to validate DSP algorithms before hardware programming.
