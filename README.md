# Synchronous-Circuit-Simulations
This repository consists of my submission for ELP201 Verilog assignments.

## Compiling Verilog code

```
iverilog -o grayctrsim grayctr.v tb_grayctr.v
```
```
iverilog -o ringctrsim ringctr.v tb_ringctr.v
```
```
iverilog -o fsmsim fsm.v tb_fsm.v
```

## Test-Bench Results

```
vvp grayctrsim
```
```
vvp ringctrsim
```
```
vvp fsmsim
```

