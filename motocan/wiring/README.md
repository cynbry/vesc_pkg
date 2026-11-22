# Wiring Guide

- All wire colors are referring to what color the wire is on the motor controller side. There are cases
where the component uses a different color wire. Discrepencies will be called out in the "Notes" column. If
you are unsure the pin number matches the datasheet pin.
- Receptable / plug is per-manufacturer definition. That means a Molex receptacle is the female pin
connector while a JST receptacle is the male pinned connector.
- No VESC pinouts are written down for the hall/taillight/headlight. This is intentional, I have not tested
the hall and my headlight/taillight were just connected to my VESC's 12V out. Set this up as you wish I do
not have a recommended setup at the moment.

## Spintend w/o VESC Express

This wiring here is the recommended configuration if you just want to get it working and no light control is acceptable.

### Main Harness

This is the 12-contact Micro-Fit receptacle (female pins) that contains display, canbus, throttle sensor, and brake sensor.

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

### Rear Light

This is the 3-contact Micro-Fit plug (male pins) that powers / controls the taillight.

| Pin # | VESC Pin | Color | Notes |
| -: | :- | :-: | :- |
| 1 | GND | Black  | Tailight GND |
| 2 | 12V | Red    | Tailight 12V |
| 3 | -   | Orange | Tailight brake signal, pull to GND to brake, component wire is yellow |

### Front Light

This is the 2-contact JST SM receptacle (male pins) that powers the headlight.

| Pin # | VESC Pin | Color | Notes |
| -: | :- | :-: | :- |
| 1 | 12V | Dark red   | Headlight 12V |
| 2 | GND | Black      | Headlight GND |

## Links

- [DigiKey Parts List](https://www.digikey.com/en/mylists/list/5D3XWRRJP3)
- [JST GH Pre-crimps](https://www.aliexpress.us/item/3256811648376831.html) - 30CM, Single Side
- [12V DC-DC Converter](https://www.aliexpress.us/item/3256809497664698.html) - 12V 1000mA, URB1D12YMD-12WR3
- [Micro-Fit 3.0 Datasheet (Dual Row)](https://www.molex.com/content/dam/molex/molex-dot-com/products/automated/en-us/productspecificationpdf/430/43045/PS-43045-001.pdf?inline)
- [Micro-Fit 3.0 Datasheet (Single Row)](https://www.molex.com/pdm_docs/sd/436400301_sd.pdf)
- [JST SM Datasheet](https://www.jst-mfg.com/product/pdf/eng/eSM.pdf)

