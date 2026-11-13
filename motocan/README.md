# MotoCAN (Motocompacto VESC Bridge)

Use at your own risk. This is a work-in-progress package for supporting the Motocompacto's display module
when connected to a VESC controller.

## Features

Currently supported features:

- Battery %
- Speed in MPH
- Mode 1 = 10MPH, Mode 2 = Unlimited
- App lock
- Handlebar sensor

Not supported:

- Usage from a VESC Express (to enable GPIO)
- Rear hall status (needs GPIO)
- Light toggle (needs GPIO)
- Charging indicator (?)

## Motocompacto Wiring

- All wire colors are referring to what color the wire is on the motor controller side. There are cases
where the component uses a different color wire. Discrepencies will be called out in the "Notes" column. If
you are unsure the pin number matches the datasheet pin.
- Receptable / plug is per-manufacturer definition. That means a Molex receptacle is the female pin
connector while a JST receptacle is the male pinned connector.
- No VESC pinouts are written down for the hall/taillight/headlight. This is intentional, I have not tested
the hall and my headlight/taillight were just connected to my VESC's 12V out. Set this up as you wish I do
not have a recommended setup at the moment.

### Main Harness

This is the 12-contact Micro-Fit receptacle that contains display, canbus, throttle sensor, and brake sensor.

| Pin # | VESC Pin | Color | Notes |
| -: | :- | :-: | :-
|  1 | CAN H        | Green  | Display CAN H  |
|  2 | CAN GND      | Black  | Display GND    |
|  3 | COMM GND     | Black  | Throttle GND   |
|  4 | -            | -      | -              |
|  5 | COMM ADC1    | Purple | Throttle Sense |
|  6 | COMM 3.3V    | Yellow | Throttle 3.3V  |
|  7 | CAN L        | Blue   | Display CAN L  |
|  8 | CAN PWR\_ON  | Orange | Display SW     |
|  9 | B+ -> 12-36V | Red    | Display Vin, please step this down if >36V, also must be live when VESC is off to power the VESC    |
| 10 | COMM GND     | Black  | Brake GND      |
| 11 | COMM ADC2    | Grey   | Brake Sense    |
| 12 | COMM 3.3V    | Yellow | Brake 3.3V     |

### Rear Hall Sensor

This is the 4-contact Micro-Fit receptable that connects to the hall sensor.

| Pin # | VESC Pin | Color | Notes |
| -: | :- | :-: | :- |
| 1 | - | Yellow | Hall 3.3V, component wire is red    |
| 2 | - | Green  | Hall Sense, component wire is brown |
| 3 | - | -      | -                                   |
| 4 | - | Black  | Hall GND                            |

### Rear Light

This is the 3-contact Micro-Fit plug that powers / controls the taillight.

| Pin # | VESC Pin | Color | Notes |
| -: | :- | :-: | :- |
| 1 | - | Black  | Tailight GND |
| 2 | - | Red    | Tailight 12V |
| 3 | - | Orange | Tailight brake signal, pull to GND to brake, component wire is yellow |

### Front Light

This is the 2-contact JST SM receptacle that powers the headlight.

| Pin # | VESC Pin | Color | Notes |
| -: | :- | :-: | :- |
| 1 | - | Dark red   | Headlight 12V |
| 2 | - | Black      | Headlight GND |
