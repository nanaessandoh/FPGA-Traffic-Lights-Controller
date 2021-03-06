# FPGA Traffic Lights Controller

In this project we implement a Traffic light Controller and prototype it on the DE1-SoC board.


### Design Specification
Starting as the N-S left-turn lights turn green:
1. The N-S left-turn lights stay green for 10 seconds. Proceed to step 2.
2. The N-S lights stay green for 20 seconds. Proceed to step 3.
3. The N-S lights turn yellow for 7 seconds. Proceed to step 4.
4. The N-S lights turn red for 20 seconds. If a car is waiting, the N-S lights stay red for an additional 7 seconds, then turn green (go back to step 1). Otherwise, the lights stay red until either a car arrives and waits or 15 seconds have passed (whichever comes first), then stay red for an additional 7 seconds, then turn green (go back to step 1).


Starting as the E-W lights turn red:
1. The E-W lights stay red for 10 + 20 + 7 seconds. Proceed to step 2.
2. The E-W left-turn lights turn green for 10 seconds. Proceed to step 3.
3. The E-W lights turn green for 20 seconds. If there is a car waiting at that point, proceed to step 4. If no car is waiting then, the light stays green until either a car shows up and waits, or 15 seconds have passed (whichever comes first), then proceed to step 3.
4. The E-W lights turn yellow for 7 seconds. Go back to step 1. 

Apart from these specification, two extra requirements are: 
* Display the current state on the onboard seven-segment display.
* Display the remaining time of the current state on the seven-segment displays.
* The onboard LEDs are used to represent the respective light that need to be on in each state. 
* Car waiting is represented by any of the onboard switches. 

A RTL Structure of the design is

    .
    ├── ...
    ├── Traffic_light.vhdl      # Top Level Entity
    │   ├── Count1S.vhdl        # Counter operating on the 50MHz clock to generate a 1 sec signal          
    │   ├── Counter_5bit.vhdl   # Counter (0-31)                
    │   └── 7segment.vhdl       # Controls the seven-segment displays       
    └── ...