# Washing Machine Controller (VHDL)

A washing machine controller for the Digilent Nexys A7 FPGA board, built around a finite state
machine. It has a manual mode, where you choose temperature, spin speed, prewash and extra rinse,
and an automatic mode with five preset programs. LEDs show the current wash stage and the
7-segment display shows the remaining time.

## How it works

The design is split into a **control unit** (the state machine) and an **execution unit** (timers,
heater, door lock, time calculator, display).

State machine stages:

```
inactive → manual_mode / auto_mode → wait_start → water_heating
         → prewashing (optional) → washing → rinsing → extra_rinsing (optional)
         → centrifugation → finishing → inactive
```

The machine won't start with the door open, and the door stays locked for the whole cycle.

### Automatic programs (`AUTO_ROM`)

| Program | Temperature | Spin speed | Prewash | Extra rinse |
|---|---|---|---|---|
| 0 | 30 °C | 1200 rpm | no | no |
| 1 | 60 °C | 800 rpm | no | no |
| 2 | 40 °C | 1000 rpm | no | yes |
| 3 | 40 °C | 1000 rpm | yes | no |
| 4 | 90 °C | 1200 rpm | no | yes |

In manual mode, temperature (30/40/60/90 °C) and speed (800/1000/1200 rpm) are cycled with buttons
and read from `TEMP_ROM` and `SPEED_ROM`.

## Components

| File | Role |
|---|---|
| `PROJECT_TOP.vhd` | Top level: wires the control and execution units to the board's buttons, LEDs and display |
| `UNIT_CONTROL.vhd` | The state machine |
| `CLOCK_DIVIDER.vhd` | Derives the timing ticks from the 100 MHz board clock |
| `MPG.vhd`, `DEBOUNCER.vhd` | Debounce the push buttons into single-cycle pulses |
| `TIMER.vhd`, `COUNTER.vhd`, `FINAL_TIMER.vhd` | Timers for each wash stage and the total time |
| `TIME_CALCULATOR.vhd` | Computes the total program duration from the chosen options |
| `HEATER.vhd` | Simulates heating the water to the target temperature |
| `DOOR_LOCK_SYSTEM.vhd` | Door lock logic |
| `AUTO_ROM.vhd`, `TEMP_ROM.vhd`, `SPEED_ROM.vhd` | Preset programs and settings |
| `SSD.vhd` | 7-segment display driver |
| `LED_CONTROLLER.vhd` | Stage, speed and temperature LEDs |

## Testing on the board

`CLOCK_DIVIDER` treats one second of the 100 MHz clock as one minute of washing, so a full cycle runs
about 60 times faster than real time and can be watched end to end on the board.

## Building

Create a Vivado project for the Nexys A7, add all `.vhd` files, set `PROJECT_TOP` as the
top module, add the board's constraints file mapped to the ports in `PROJECT_TOP`, then synthesize,
implement and program the device.
