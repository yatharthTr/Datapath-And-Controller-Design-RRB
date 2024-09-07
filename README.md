# Round-Robin Arbiter with Datapath and Controller in Verilog

This repository contains a Verilog implementation of a round-robin arbiter with 8 channels. The arbiter uses a datapath and controller-based approach to handle requests and priorities in a sequential manner. It includes various registers, linkages,counters and comparators to manage the arbitration process.

## Overview

The round-robin arbiter is designed to schedule access among multiple channels using a round-robin algorithm. The arbiter's datapath handles the data flow and state management, while the controller manages the sequencing and control signals. The system ensures fair access to channels based on request priorities and handles cases where no requests are active by defaulting to the first channel.

## Modules

### Datapath Modules

#### 1. **RRB_MUX**
- **Function:** Converts one-hot encoding to decimal encoding.
- **Description:** Takes a one-hot encoded grant vector and converts it to a decimal format for easier handling in other modules.

#### 2. **structural_g_r**
- **Function:** Manages grant requests.
- **Description:** Handles the grant request logic and interacts with other datapath modules to ensure correct request processing.

#### 3. **structure_ngprc**
- **Function:** Calculates the next grant based on the current state.
- **Description:** Implements the next grant precalculator with a focus on structural design, determining the next channel to grant access based on request priorities.

#### 4. **Struc_rrbfinal**
- **Function:** Integrates the datapath components.
- **Description:** The top-level datapath module that coordinates the operation of the other datapath modules, ensuring proper data flow and state transitions.

### Controller Modules

#### 1. **controller_g_r**
- **Function:** Controls the grant request processing.
- **Description:** Manages control signals and sequencing for the grant request calculations, interfacing with the datapath modules to ensure proper operation.

#### 2. **controller_ngprc**
- **Function:** Controls the next grant precalculation.
- **Description:** Manages control signals and sequencing for the next grant precalculation process, ensuring that the next grant is calculated and updated correctly.

### Testbench

#### 1. **tb_struc_RRB**
- **Function:** Tests the structural round-robin arbiter.
- **Description:** Simulates the top-level datapath and controller modules to verify correct functionality and handle various test scenarios.


## Module Descriptions

- **RRB_MUX.v:** Contains the Verilog code for converting one-hot encoding to decimal encoding.
- **structural_g_r.v:** Contains the Verilog code for managing grant requests.
- **structure_ngprc.v:** Contains the Verilog code for the next grant precalculator.
- **Struc_rrbfinal.v:** Contains the top-level datapath module integrating all datapath components.
- **controller_g_r.v:** Contains the Verilog code for controlling the grant request processing.
- **controller_ngprc.v:** Contains the Verilog code for controlling the next grant precalculation.
- **tb_struc_RRB.v:** Contains the testbench code for simulating the structural round-robin arbiter.


![image](https://github.com/user-attachments/assets/89f3f124-5cfd-42ec-95f7-e1ae8261131a)
![image](https://github.com/user-attachments/assets/76e9ee88-9b64-4a2c-81dd-59f16c7b47e6)

