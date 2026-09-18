# FPGA-Based Image Processing – Verilog

This project implements basic **real-time image processing operations on an FPGA** using **Verilog HDL**.

The image data is stored in **Block RAM (BRAM)** and processed using custom RTL logic before being displayed on a VGA monitor. The project demonstrates how fundamental image-processing operations can be implemented directly in digital hardware.

## Overview

The project implements the following image-processing operations:

- Brightness Increase
- Brightness Decrease
- Grayscale / Black-and-White Conversion
- Image Negative

The processed image is displayed on a **VGA monitor** using an FPGA-based VGA controller.

## System Architecture

```text
              ┌──────────────┐
              │   Image Data │
              │    (BRAM)    │
              └──────┬───────┘
                     │
                     ▼
              ┌──────────────┐
              │    Image     │
              │  Processing  │
              │    Logic     │
              └──────┬───────┘
                     │
                     ▼
              ┌──────────────┐
              │ VGA Timing   │
              │  Controller  │
              └──────┬───────┘
                     │
                     ▼
              ┌──────────────┐
              │ VGA Monitor  │
              │   Display    │
              └──────────────┘
