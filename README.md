# ⚡ SystemVerilog Codes

### RTL Design • Digital Design • Verification • FPGA • VLSI

A growing collection of **SystemVerilog and Verilog RTL designs, digital circuits, hardware controllers, interfaces, memories, testbenches, and verification exercises**.

This repository documents my hands-on journey from **fundamental digital logic to practical RTL design and hardware verification**, with implementations ranging from basic gates and flip-flops to communication protocols, memory systems, clock-domain crossing, bus interfaces, controllers, and processor-oriented hardware.

> **Design → Simulate → Debug → Verify → Improve**

---

## 📌 About This Repository

`systemverilog-codes` is a practical hardware-design repository focused on learning and implementing **RTL and digital hardware concepts through code**.

The repository is organized around progressively more complex hardware concepts:

**Digital Logic**
→ **Combinational Design**
→ **Sequential Design**
→ **FSMs**
→ **Memory**
→ **Controllers**
→ **Interfaces**
→ **CDC**
→ **Verification**
→ **FPGA / VLSI-Oriented Design**

The goal is not simply to collect HDL programs, but to build a strong understanding of how digital hardware is **designed, simulated, verified, debugged, and improved**.

---

# 🎯 Repository Objectives

The main objectives of this repository are to:

- Learn and strengthen SystemVerilog/Verilog fundamentals
- Develop practical RTL coding skills
- Understand digital circuit architecture
- Implement combinational and sequential logic
- Design reusable hardware modules
- Develop simulation-oriented testbenches
- Practice functional verification
- Analyze simulation behavior and waveforms
- Understand hardware debugging techniques
- Explore communication and bus interfaces
- Study clock-domain crossing techniques
- Build memory and storage structures
- Develop FPGA-oriented RTL
- Progress toward professional RTL design and verification
- Build a strong foundation for VLSI engineering

---

# 🚀 What You'll Find Here

The repository covers a wide range of digital hardware designs.

### 🔌 Digital Logic

- Logic Gates
- Half Adder
- Full Adder
- Half Subtractor
- Full Subtractor
- Ripple Carry Adder
- Binary Subtractor
- Multiplexers
- Demultiplexers
- Encoders
- Decoders
- Comparators

### 🔢 Arithmetic & Data Conversion

- Binary Multipliers
- Array Multipliers
- Binary Dividers
- Carry Look-Ahead Adder
- Carry Save Adder
- Carry Select Adder
- Arithmetic Shifter
- BCD Converters
- Binary-to-BCD
- BCD-to-Binary
- Excess-3 Converters
- Binary-to-Gray Converter
- CRC Generator
- CRC Checker
- Hamming Code

### 🔄 Sequential Logic

- D Flip-Flop
- JK Flip-Flop
- T Flip-Flop
- Flip-Flops with Reset
- Registers
- PIPO
- SIPO
- PISO
- SISO
- Universal Shift Register
- Ring Counter
- Johnson Counter
- Up Counters
- Down Counters
- Up/Down Counters
- Synchronous Counters
- Asynchronous Counters
- BCD Counters
- Mod-N Counters
- Frequency Dividers

### 🧠 Finite State Machines

- Simple FSM
- Mealy FSM
- Moore FSM
- Sequence Detectors
- Traffic Light Controller
- Elevator Controller
- Vending Machine FSM
- Washing Machine Controller
- Digital Lock

### 💾 Memory & Storage

- RAM
- ROM
- Dual-Port RAM
- Register File
- FIFO
- Stack / LIFO Memory
- Memory Arrays
- Read/Write Control

### 📡 Communication Interfaces

- UART Transmitter
- UART Receiver
- SPI Master
- I²C Master
- APB Slave
- AXI4-Lite Master
- AXI4-Lite Slave
- AXI-Stream Master
- Wishbone-Compatible Slave

### 🔀 Clock Domain Crossing

- 2-Flip-Flop Synchronizer
- Asynchronous Reset Synchronizer
- Handshake-Based CDC
- Pulse Synchronizer
- Toggle Synchronizer
- Event Detection

### ⚙️ Hardware Controllers & Peripherals

- GPIO Controller
- PWM Generator
- PWM Controller
- Servo Motor Controller
- Stepper Motor Controller
- DC Motor Direction Controller
- Push-Button Debounce
- Watchdog Timer
- Frequency Counter
- Digital Stopwatch
- Digital Clock
- Programmable Interval Timer
- Programmable Interrupt Controller
- DMA Controller
- Round-Robin Arbiter

The repository also contains testbenches corresponding to many of these designs.

---

# 🏗️ Design Domains

The repository can broadly be viewed through the following hardware-design layers:

```text
                    ┌───────────────────────┐
                    │   Processor / Systems │
                    └───────────┬───────────┘
                                │
                    ┌───────────▼───────────┐
                    │ Controllers & Buses   │
                    └───────────┬───────────┘
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
        ┌─────▼─────┐     ┌────▼─────┐     ┌────▼─────┐
        │ Interfaces │     │ Memories │     │   CDC    │
        └─────┬─────┘     └────┬─────┘     └────┬─────┘
              │                │                 │
              └────────────────┼─────────────────┘
                               │
                    ┌──────────▼──────────┐
                    │      RTL Design    │
                    └──────────┬──────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
        ┌─────▼─────┐    ┌─────▼─────┐   ┌──────▼──────┐
        │Sequential │    │   FSMs    │   │Combinational│
        │  Logic    │    │           │   │    Logic    │
        └─────┬─────┘    └─────┬─────┘   └──────┬──────┘
              │                │                │
              └────────────────┼────────────────┘
                               │
                    ┌──────────▼──────────┐
                    │ Digital Fundamentals│
                    └─────────────────────┘
```

---

# 🗂️ Repository Structure

The repository is continuously evolving, so the structure grows alongside the learning journey.

A conceptual organization of the designs is:

```text
systemverilog-codes/
│
├── Digital Logic/
│   ├── Logic Gates/
│   ├── Half Adder/
│   ├── Full Adder/
│   ├── Half Subtractor/
│   └── Full Subtractor/
│
├── Combinational Logic/
│   ├── Multiplexer/
│   ├── Demultiplexer/
│   ├── Encoder/
│   ├── Decoder/
│   ├── Comparator/
│   └── ALU/
│
├── Arithmetic/
│   ├── Adders/
│   ├── Subtractors/
│   ├── Multipliers/
│   ├── Dividers/
│   └── Shifters/
│
├── Sequential Logic/
│   ├── Flip-Flops/
│   ├── Registers/
│   ├── Shift Registers/
│   └── Counters/
│
├── FSM/
│   ├── Mealy/
│   ├── Moore/
│   ├── Sequence Detectors/
│   └── Controllers/
│
├── Memory/
│   ├── RAM/
│   ├── ROM/
│   ├── FIFO/
│   ├── Stack/
│   └── Register File/
│
├── Interfaces/
│   ├── UART/
│   ├── SPI/
│   ├── I2C/
│   ├── APB/
│   ├── AXI/
│   └── Wishbone/
│
├── CDC/
│   ├── Synchronizers/
│   ├── Handshake/
│   ├── Pulse Synchronizer/
│   └── Toggle Synchronizer/
│
├── Controllers/
│   ├── GPIO/
│   ├── DMA/
│   ├── PIC/
│   ├── Timers/
│   └── Motor Controllers/
│
├── Testbenches/
│
└── README.md
```

> The actual GitHub repository currently contains many individual modules and testbench repositories/files rather than necessarily following this exact physical folder hierarchy. The structure above is the **logical organization** of the work.

---

# 🛠️ Technology Stack

## Hardware Description Languages

- **SystemVerilog**
- **Verilog**

## Core Concepts

- RTL Design
- Digital Logic
- Sequential Logic
- Combinational Logic
- Finite State Machines
- Memory Design
- Interface Design
- Hardware Verification
- Simulation
- Synthesis Concepts
- FPGA-Oriented Design

## Tools

Tools used or explored during the learning process include:

- Xilinx Vivado
- ModelSim
- QuestaSim
- GTKWave
- Git
- GitHub

Tool usage may vary depending on the individual design and simulation environment.

---

# 🧪 Verification & Testbench Development

Verification is an important part of this repository.

Many designs are accompanied by dedicated testbenches used to provide stimulus, observe outputs, and verify expected behavior.

The repository includes testbenches for designs such as:

- Counters
- Adders
- Multipliers
- Comparators
- Encoders
- Decoders
- Shift Registers
- Flip-Flops
- FSMs
- Memories
- FIFO
- UART
- SPI
- I²C
- PWM
- Controllers
- CDC modules
- AXI/APB/Wishbone interfaces
- Peripheral controllers

The repository currently contains a substantial collection of dedicated testbench implementations.

---

# 🔬 Verification Workflow

The general verification process followed in the repository is:

```text
        RTL Design
             │
             ▼
       Create Testbench
             │
             ▼
      Generate Stimulus
             │
             ▼
       Run Simulation
             │
             ▼
      Observe Waveforms
             │
             ▼
 Compare Expected / Actual
             │
        ┌────┴────┐
        │         │
      PASS       FAIL
        │         │
        │         ▼
        │       Debug
        │         │
        │         ▼
        │      Modify RTL
        │         │
        │         └───────┐
        │                 │
        └──────────► Re-Test
                          │
                          ▼
                   Verified Design
```

---

# 🔄 RTL Design Workflow

A practical hardware-development workflow used throughout the learning process:

```text
1. Understand the Specification
                ↓
2. Define Hardware Architecture
                ↓
3. Design RTL
                ↓
4. Create Testbench
                ↓
5. Generate Test Stimulus
                ↓
6. Run Simulation
                ↓
7. Analyze Waveforms
                ↓
8. Debug
                ↓
9. Refactor / Optimize
                ↓
10. Verify Functionality
                ↓
11. Synthesis / FPGA Implementation
```

This workflow emphasizes that writing RTL is only one part of hardware development.

---

# 📚 Core Topics

## 1. Digital Design Fundamentals

- Logic Gates
- Boolean Logic
- Adders
- Subtractors
- Multiplexers
- Demultiplexers
- Encoders
- Decoders
- Comparators
- Arithmetic Circuits

## 2. Sequential Design

- Flip-Flops
- Registers
- Shift Registers
- Counters
- Timers
- Frequency Dividers

## 3. FSM Design

- State Machines
- Moore Machines
- Mealy Machines
- Sequence Detection
- Control Logic
- Real-World Controllers

## 4. Memory Design

- RAM
- ROM
- FIFO
- Register Files
- Stack Memory
- Dual-Port Memory

## 5. Communication & Bus Protocols

- UART
- SPI
- I²C
- APB
- AXI4-Lite
- AXI-Stream
- Wishbone

The repository already includes implementations and/or testbenches for several of these interfaces.

## 6. Clock Domain Crossing

- Synchronizers
- Reset Synchronization
- Handshake Synchronization
- Pulse Synchronization
- Toggle Synchronization
- Event Detection

## 7. Hardware Controllers

- DMA
- GPIO
- Interrupt Controllers
- Timers
- PWM
- Motor Controllers
- Digital Systems

---

# 💡 Skills Being Developed

### 🔌 Digital Design

- RTL Coding
- Combinational Circuit Design
- Sequential Circuit Design
- FSM Implementation
- Register Design
- Counter Design
- Memory Design
- Interface Design

### 🧪 Verification

- Testbench Development
- Functional Verification
- Simulation
- Waveform Analysis
- Debugging
- Expected vs Actual Output Analysis

### 🚀 FPGA Development

- RTL-Based Design
- Simulation
- Synthesis Concepts
- FPGA Design Workflow
- Hardware Implementation

### 🛠️ Engineering Practices

- Modular Design
- Reusable RTL
- Structured Coding
- Documentation
- Version Control
- Debugging
- Iterative Development

---

# 📊 Learning Progress

Progress in this repository represents an evolving personal learning journey rather than formal certification or completed coursework.

| Area | Status |
|---|---|
| Digital Design Fundamentals | ✅ Strong Foundation |
| Combinational RTL | ✅ Practiced |
| Sequential RTL | 🚧 Expanding |
| Counters & Registers | 🚧 Expanding |
| FSM Design | 🚧 Expanding |
| Memory Design | 🚧 Expanding |
| Testbench Development | 🚧 Active |
| Communication Interfaces | 🚧 Active |
| CDC Design | 🚧 Active |
| Hardware Controllers | 🚧 Active |
| FPGA Development | 🚧 Learning |
| Advanced Verification | 🔜 Planned |
| UVM | 🔜 Planned |
| ASIC Design Flow | 🔜 Planned |

---

# 🛣️ Learning Roadmap

## ✅ Completed / Practiced

- SystemVerilog / Verilog fundamentals
- Modules and ports
- Data types
- Operators
- Basic digital circuits
- Combinational logic
- Basic sequential circuits
- Flip-flops
- Registers
- Counters
- Shift registers
- Basic FSMs
- Digital controllers

## 🚧 Currently Expanding

- Advanced RTL design
- Testbench development
- Functional verification
- Memory systems
- Communication interfaces
- CDC techniques
- Hardware controllers
- FPGA-oriented designs
- More complex RTL architectures

## 🔜 Future Direction

### Verification

- SystemVerilog Assertions
- Advanced verification methodologies
- UVM fundamentals
- Constrained-random verification
- Functional coverage
- Advanced testbench architecture

### Digital Design

- FIFO architectures
- Cache memory
- Pipelined architectures
- Processor components
- RISC-V concepts

### Interfaces

- UART
- SPI
- I²C
- AXI
- Additional bus architectures

### VLSI

- ASIC Design Flow
- RTL-to-GDS concepts
- Timing Analysis
- Clock Domain Crossing
- Low-Power Design
- Design for Testability

The original roadmap already identifies UVM, advanced verification, FIFO, cache, processor components, RISC-V, ASIC flow, timing analysis, CDC, low-power design, and DFT as future areas.

---

# 🧠 From Fundamentals to Systems

The progression of this repository can be represented as:

```text
Digital Logic
     ↓
Combinational Circuits
     ↓
Sequential Circuits
     ↓
Registers & Counters
     ↓
Finite State Machines
     ↓
Memory Systems
     ↓
Controllers
     ↓
Communication Interfaces
     ↓
Clock Domain Crossing
     ↓
Verification
     ↓
FPGA Systems
     ↓
Processor Components
     ↓
Advanced RTL / VLSI
```

The purpose of this progression is to gradually connect individual digital circuits to larger hardware systems.

---

# 🔭 Future Vision

The long-term vision is to transform this repository into a comprehensive **RTL Design and Hardware Verification knowledge base**.

Future work will progressively move toward:

```text
Basic Digital Design
        ↓
RTL Design
        ↓
Advanced RTL
        ↓
Verification
        ↓
UVM
        ↓
Computer Architecture
        ↓
Processor Design
        ↓
RISC-V
        ↓
ASIC Design
        ↓
VLSI Design & Verification
```

The repository will continue expanding with practical implementations rather than remaining limited to theoretical examples.

---

# 📈 Repository Growth

As the learning journey progresses, the repository will continue to grow across:

- 📚 HDL implementations
- ⚡ RTL modules
- 🔄 Sequential designs
- 🧠 FSM projects
- 💾 Memory architectures
- 📡 Communication interfaces
- 🔀 CDC designs
- 🧪 Testbenches
- ✅ Verification exercises
- 📊 Simulation examples
- ⚙️ Hardware controllers
- 🚀 FPGA projects
- 🧩 Processor components
- 🔬 VLSI-oriented designs

---

# 🧩 Featured Design Areas

Some of the more system-oriented work in the repository includes:

### AXI

- AXI4-Lite Master
- AXI4-Lite Slave
- AXI-Stream Master

### Peripheral & System Controllers

- DMA Controller
- Programmable Interrupt Controller
- Programmable Interval Timer
- GPIO Controller
- Watchdog Timer
- Round-Robin Arbiter

### CDC

- 2-Flip-Flop Synchronizer
- Handshake-Based CDC
- Pulse Synchronizer
- Toggle Synchronizer
- Asynchronous Reset Synchronizer

### Hardware Interfaces

- UART
- SPI
- I²C
- APB
- Wishbone

These designs represent the repository's movement beyond isolated logic circuits toward **system-level RTL concepts**.

---

# 🎓 Learning Philosophy

> **Design. Simulate. Debug. Verify. Improve.**

Hardware development requires more than writing RTL.

Every design should be:

- Designed carefully
- Simulated thoroughly
- Debugged systematically
- Verified against expected behavior
- Improved through iteration

Every RTL module strengthens digital-design understanding.

Every testbench strengthens verification skills.

Every simulation develops debugging ability.

Every hardware interface introduces another layer of system understanding.

Every completed design moves the learning journey closer to professional RTL and VLSI engineering.

---

# 🤝 Contributing

This is primarily a personal learning repository, but suggestions, discussions, corrections, and improvements are welcome.

If you would like to contribute:

```bash
# Fork the repository

# Create a feature branch
git checkout -b feature/your-feature

# Make your changes

# Commit
git commit -m "Add: your improvement"

# Push
git push origin feature/your-feature

# Open a Pull Request
```

When contributing RTL, consider including:

- Clear module naming
- Meaningful signal names
- Comments where necessary
- A corresponding testbench
- Expected behavior
- Simulation results where appropriate

---

# ⭐ Support

If you find this repository useful:

⭐ **Star the repository**

🍴 **Fork the project**

💬 **Share feedback**

Your support helps motivate continued exploration of digital design, RTL development, verification, and VLSI engineering.

---

# 👨‍💻 About the Author

## Mohammad Naveed

**Aspiring VLSI Design & Verification Engineer | Java Full Stack Developer**

Interested in:

- Digital Electronics
- SystemVerilog
- Verilog
- RTL Design
- Hardware Verification
- FPGA Development
- Digital Architecture
- VLSI
- Java
- Full Stack Development
- Software Engineering

Currently building practical knowledge across **hardware and software engineering** through continuous learning and project-based development.

---

# 🌐 Connect With Me

### GitHub

**Mohammad Naveed**  
https://github.com/mdnav

### LinkedIn

**Mohammad Naveed**  
https://www.linkedin.com/in/mdnav/

---

# ⚡ Final Thought

> **Great hardware starts with clear architecture, becomes real through RTL, and becomes reliable through verification.**

### Design • Simulate • Debug • Verify • Improve

**Made with ❤️ by Mohammad Naveed**

⭐ If you find this repository useful, consider starring it.
