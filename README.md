#  Colors Module and a Minimalist Watchface

***Christopher Evans, Garmin 2020 Connect IQ Challenge***

My two goals for this challenge were:

- Build a maintainable open source Monkey Barrel for an RGB color implementation.

- Build an application to showcase the features of the Monkey Barrel.

  

__Motivation:__ The Venu is the first high-performance athletic wearable from Garmin to include an OLED screen. The hardware for giving athletes a more vibrate experience is now available, although Monkey C and Toybox are still using bare-bones color representation. With the lack of easy-to-use color datatypes, the ConnectIQ store lacks applications with the richness that an OLED screen is capable of. My solution is to develop an accessible and open-source library dedicated to color. Alongside this library, I will add the first Watchface that _programmatically_ stretches the Venu's OLED to its limits.

  

_The Colors Module will be packaged as a monkey barrel (Library) and be compatable with a greater array of watches._

  

# The Minimalist Watchface

Version: _0.1 - 08/07/2020_

Author: _Christopher Evans_

  

The Minimalist Watchface was built to provide athletes an at-a-glance view of vitals while remaining uncluttered and beautiful.

  

_The Minimalist Watchface was designed and built alongside the Colors Library to showcase most of the features in Colors._

  

### Run Config:

  

- WatchFace: Venu / Venu special edition

- SDK : 3.1

  

## Day Gradient

__As the day progresses, the sun rotates around the watchface.__

![Day](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Watchface_Intro.png)

  

__The sky uses `Colors.drawCurvedGradient()` to grade across the watchface. The font color swaps between theme accents to be more readable as the overlaps the UI.__  

![Evening](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Watchface_sunset.png)

  

__As the sky rotates, both the inner and outer RGB colors grade over time from Sky Blue to Night Violet and Sun Orange to Moon White.__  

![Night](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Watchface_midnight.png)

  

__All 3 unique color gradients used to color the backdrop result in a natural minimalist display over time.__  

![Morning](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Watchface_morning.png)

  

## Heartrate

While a heartrate is detected, the athlete's BPM is displayed and colored by the standard 5 heartrate zones:

- __Resting Zone__  
![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/White.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/White.png)

- __Heart Healthy Zone__  
![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Green.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Green.png)

- __Weight Management Zone__  
 ![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Blue.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Blue.png)

- __Aerobic Zone__  
 ![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Yellow.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Yellow.png)

- __Aerobic Threshold Zone__  
 ![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Orange.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Orange.png)

- __Redline Zone__  
 ![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Red.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Heartrate/Red.png)

  

  

## Battery and Bluetooth

While an athlete depletes their charge, the battery indicator uses Colors.Gradient() to grade between colors and provide an at-a-glance reference for remaining power.

![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/100.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/100.png)&nbsp;&nbsp;&nbsp;&nbsp;_100%_  

![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/80.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/80.png)&nbsp;&nbsp;&nbsp;&nbsp;_80%_  

![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/60.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/60.png)&nbsp;&nbsp;&nbsp;&nbsp;_60%_  

![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/40.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/40.png)&nbsp;&nbsp;&nbsp;&nbsp;_40%_  

![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/20.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/20.png)&nbsp;&nbsp;&nbsp;&nbsp;_20%_ 

![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/0.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/0.png)&nbsp;&nbsp;&nbsp;&nbsp;_0%_  

![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Charging.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Charging.png)&nbsp;&nbsp;&nbsp;&nbsp;_30% - Charging_  

The bluetooth icon appears next to the battery icon while connected.

![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/80.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/battery/80.png)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ![https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Bluetooth_small.png](https://raw.githubusercontent.com/ChrisWeldon/GarminVenuAvatar/master/docimages/Bluetooth_small.png)

  

# Colors Monkey Barrel

Version: _0.1 - 08/07/2020_

Author: _Christopher Evans_

  

__Philosophy__: Colors is built to add functionality while still integrating with the existing methods and classes. Every method and class within `Colors` is developed with `Colors::rgb` in mind. The simple addition of an rgb class allows for unlimited possibilities in grading, theming, and programmatic color selection.

  

Version 0.1 of Colors is the first attempt at implementing some of these possibilities.

  

## Introduction to Colors

  

### Colors::rgb

An rgb instance can be initiated in a number of different ways.

```

var darkgreen = new Colors.rgb(0x00ab18);

var darkblue = Colors.valsToRGB(6, 0, 171);

var unknown = Colors.randRGB();

```

Operations can be performed on 24bit colors.

  

```

darkgreen.getG(); // 171

darkblue.getHex(); // 0x0600AB

darkgreen.setR(200).getHex(); // 0xc8ab18 Light Purple

  

var new_color = darkgreen.add(darkblue);

new_color.toString(); // rgb(200, 171, 195)

```

  

### Colors::Palette

Palettes are used to represent an ordered collection of colors.

```

const  theme  =  new  Colors.Palette([

{"dominant"  =>  new  Colors.rgb(0x4281a4)},

{"accent0"  =>  new  Colors.rgb(0x9cafb7)},

{"accent1"  =>  new  Colors.rgb(0xead2ac)},

{"standard"  =>  new  Colors.rgb(0xffffeb)},

]);

// or

const  hr_palette  =  new  Colors.Palette([

{"resting"  =>  Colors.valsToRGB(255,  255,  255)},

{"healthy"  =>  Colors.valsToRGB(123,  255,  130)},

{"weight"  =>  Colors.valsToRGB(123,  181,  255)},

{"aerobic"  =>  Colors.valsToRGB(245,  255,  123)},

{"threshold"  =>  Colors.valsToRGB(255,  205,  123)},

{"redline"  =>  Colors.valsToRGB(255,  123,  123)}

]);

  

// or

  

const  day_palette  =  Colors.createPaletteFromHex([

{"0_midnight"  =>  0x191469  },

{"1_preastro"  =>  0x544eb4  },

{"2_sunup"  =>  0xffc2b7  },

{"3_preday"  =>  0x00a3f2  },

{"4_midday"  =>  0x0081ff  },

{"5_precivil"  =>  0x2a96ff  },

{"6_sundown"  =>  0xff76a2  },

{"7_prenight"  =>  0x544eb4  },

]);

```

Palettes can be changed and used after initiation.

```

theme.get('dominant'); // rgb(66, 129, 164)

theme.put('accent2', new Colors.valsToRGB(255, 205, 0));

```

Palettes are really great for clean constant initiation and persistent themes throughout views and layouts.

  

The `Palette.toArray()` function allows for easy integration with bitmaps.

  

### Colors::Gradient

Gradients are a datatype used to represent the grade between 2 or more colors.

  

```

var basic_grad = new Colors.Gradient(darkgreen, darkblue, 10);

// or with more than one color

var sky_grad  =  Colors.createGradientFromPalette(day_palette,  [15,  12,  13,  32,  32,  13,  12,  15]  ,  true);

```

Once created, can be mutated.

```

basic_grad.concat(new Colors.Gradient(darkblue, unknown, 10)); // new size is 20.

  

basic_grad.get(5); // rgb(3, 87, 96)

```

  

  

## API Reference - Module: Colors

  

**Instance Methods**

`createPaletteFromHex(array) => Colors::Palette`

&nbsp;&nbsp;&nbsp;&nbsp; A helper function to build a Colors:Palette from an array of dictionaries containing Hex (Toybox:Lang:Number) values instead of rgb values (Colors:rgb).

_Parameters_:

- `array` (Toybox:Lang:array) an array of dictionaries

eg:  ```[ {:symbol => (Toybox:Lang:Number)} ]```

  

Returns: (Colors::Palette) The resulting Palette.

  

---------

`createGradientFromPalette(palette,  widths,  circular) => Colors::Gradient`

&nbsp;&nbsp;&nbsp;&nbsp;A helper function to build a Colors:Gradient from a Colors:Palette.

_Parameters_:

- `palette` (Colors:Palette)  a palette containing the (Colors:rgb) which will be compiled into a gradient

- `widths` (Toybox:Lang:Array) an array of (Toybox:Lang:Numbers) determining the width of the grade between

- `circular` (Toybox:Land:Boolean)  true concats gradient of last palette color to first. If true, widths.size() == palette.size()

  

_Returns_: (Colors::Gradient) The resulting gradient.

  

------

`drawCurvedGradient(dc,  x,  y,  r,  gradient)`

&nbsp;&nbsp;&nbsp;&nbsp;A helper function to draw a circular gradient. Implentation uses iterator methods.

_Parameters_:

- `dc` (Toybox:Graphics:Dc)  the device context.

- `x` (Toybox:Lang:Number)  the x coord for the center of the circular gradient center.

- `y` (Toybox:Lang:Number)  the y coord for the center of the cicular gradient center.

- `r` (Toybox:Lang:Number)  the radius for the circular gradient

- `gradient` (Colors:Gradient)  the gradient to draw

------

`drawCurvedGradientRA(dc,  x,  y,  r,  gradient)`

&nbsp;&nbsp;&nbsp;&nbsp;A helper function to draw a circular gradient. Signature Identical to `Colors.drawCurvedGradient()`, implementation changed to have different memery  and cpu implications.

  

--------

`drawRectGradient(dc,  x,  y,  width,  height,  gradient,  vertical)`

&nbsp;&nbsp;&nbsp;&nbsp;A helper function to draw a rectangular gradient.

_Parameters_:

- `dc` (Toybox:Graphics:Dc) -  the device context.

- `x` (Toybox:Lang:Number) - the x coord for the upper left corner of the gradient.

- `y` (Toybox:Lang:Number) - the y coord for the upper left corner of the gradient.

- `width` (Toybox:Lang:Number) - width of the gradient.

- `height` (Toybox:Lang:Number) -  height of the gradient.

- `gradient` (Colors:Gradient) - the gradient to draw.

- `vertical` (Toybox:Lang:Boolean) - the orientation of the gradient. the value of true will draw a vertical gradient.

  

---------

`valsToRGB(r,  g,  b) => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp;A helper function to allow for creation of rgb object through individual r g b values.

_Parameters_:

- `r` (Toybox:Lang:Number)  - the value from [0, 255] inclusive for Red.

- `g` (Toybox:Lang:Number)  - the value from [0, 255] inclusive for Green.

- `b` (Toybox:Lang:Number) - the value from [0, 255] inclusive for Blue.

  

_Returns:_ (Colors::rgb) The rgb value formed form the parameters.

  

--------

`randRGB() => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp;A random color generator seeded through `Math.srand()`.

_Returns_: (Colors::rgb) A random 24bit rgb value.

  

## **Class: Colors::rgb**

A class to represent a 24 bit color.

*Superclass: Toybox:Lang:Number*

**Constructor Details**

`initialize(hex) => Colors::rgb`

_Parameters_:

- `hex` (Toybox::Lang::Number) - 24 bit unsigned integer

  

**Instance Method Details**

  

`toString() => Toybox::Lang::String`

&nbsp;&nbsp;&nbsp;&nbsp;A readable string of the rgb values.

_Returns_: (Toybox::Lang::String) version of rgb as a string.

  

---------

`toNumber() => Toybox::Lang::Number`

&nbsp;&nbsp;&nbsp;&nbsp;A number representation of the instance.

_Returns_: (Toybox::Lang::Number) version of rgb as a 24 bit integer.

  

--------

`setR(r) => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp;Set red from [0, 255] inclusive.

_Parameters_:

- `r` (Toybox::Lang::Number) - new rgb.red instance variable value

  

_Returns_:  mutated `self` (Colors::rgb)

  

--------

`setG(g) => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp;Set green from [0, 255] inclusive.

_Parameters_:

- `g` (Toybox::Lang::Number) - new rgb.green instance variable value

  

_Returns_:  mutated `self` (Colors::rgb)

  

--------

`setB(b) => Colors::rgb` (Colors::rgb)

&nbsp;&nbsp;&nbsp;&nbsp;Set blue from [0, 255] inclusive.

_Parameters_:

- `b` (Toybox::Lang::Number) - new rgb.blue instance variable value

  

_Returns_:  mutated `self`  (Colors::rgb)

  

--------

`setRGB(r, b, g) => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp;Set red, green, and blue from [0, 255].

_Parameters_:

- `r` (Toybox::Lang::Number) - rgb.red instance variable setter.

- `g` (Toybox::Lang::Number) - rgb.green instance variable setter.

- `b` (Toybox::Lang::Number) - rgb.blue instance variable setter.

  

_Returns_:  mutated `self`  (Colors::rgb)

  

--------

`getR() => Toybox::Lang::Number`

&nbsp;&nbsp;&nbsp;&nbsp;Get red value of instance.

_Returns_: instance variable for red (Toybox::Lang::Number)

  

--------

`getG() => Toybox::Lang::Number`

&nbsp;&nbsp;&nbsp;&nbsp;Get green value of instance.

_Returns_: instance variable for green (Toybox::Lang::Number)

  

--------

`getB() => Toybox::Lang::Number`

&nbsp;&nbsp;&nbsp;&nbsp;Get blue value of instance.

_Returns_: instance variable for blue (Toybox::Lang::Number)

  

--------

`getRGB() => Toybox::Lang:Dictionary`

&nbsp;&nbsp;&nbsp;&nbsp;Get Red, Green, and Blue

_Returns_: instance in Dictionary with keys `['r', 'g', 'b']`

  

--------

`add(c) => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp;Immutibly add rgb value to instance.

_Parameters_:

- `c` (Colors::rgb) - the color to be added to instance.

Returns: new instance of (Colors::rgb).

  

--------

`subtract(c) => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp;Immutibly subtract rgb value to instance.

_Parameters:_

- `c` (Colors::rgb) - the color to be subtracted to instance.

  

_Returns_: new instance of (Colors::rgb).

  

--------

`copy() => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp;

_Returns_: New duplicate instance of rgb.

  

  

## **Class: Colors::Palette**

An object to represent an ordered and named collection of rgb colors

*Superclass: Toybox:Lang:Array*

**Constructor Details**

`initialize(array) => Colors::rgb`

_Parameters_:

- array (Toybox::Lang::Array) - An array of 1 entry dictionaries

[ {:symbol => (Colors:rgb)} ]

  

_Note: the odd parameter format is to preserve the visually simple dictionary definition while also allowing for ordered elements. Still exploring alternatives._

  

**Instance Method Details**

  

`toString() => Toybox::Lang::String`

_Returns_: a readable string representation of instance.

  

--------

`getValues() => Toybox::Lang::Array`

_Returns_: Instances values.

  

--------

`getKeys() => Toybox::Lang::Array`

_Returns_: Instances keys.

  

--------

`get(key) => Colors::rgb`

_Parameters_:

- `key` (Toybox::Lang::Symbol) - The key of the desired value.

  

_Returns_:  Color put at given key

  

--------

`put(key, val) => Colors::Palette`

_Parameters_:

- `key` (Toybox::Lang::Symbol) - The key of value to be put.

- `val` (Colors::rgb) - the val assigned at key.

  

_Returns_: `self`

  

## **Class: Colors::Gradient**

A class to represent a collected of grading rgb colors.

**Constructor Details**

`initialize(outer, inner, w) => Colors::Gradient`

_Parameters_:

- `outer` (Colors::rgb) - Starting gradient color.

- `inner` (Colors::rgb) - Ending gradient color.

- `w` (Toybox::Lang::Number) - number of steps between `outer` and `inner`.

  

**Instance Method Details**

  

`concat(gradient) => Colors::Gradient`

&nbsp;&nbsp;&nbsp;&nbsp; Concatinates a gradient with self. This function mutates the calling instance.

_Parameters_:

- `gradient` (Colors::Gradient) - The gradient to be concatinated onto calling instance.

  

_Returns_: mutated self (Colors::Gradient)

  

--------

`toString() => Toybox::Lang::String`

&nbsp;&nbsp;&nbsp;&nbsp;A readable string of the instances rgb values.

_Returns_: (Toybox::Lang::String) version of gradient as a string.

  

--------

`hasNext() => Toybox::Lang::Boolean`

&nbsp;&nbsp;&nbsp;&nbsp;An iterable-like hasNext() function.

_Returns_: (Toybox::Lang::Boolean) If instance iteration has next.

  

------

`hasPrev() => Toybox::Lang::Boolean`

&nbsp;&nbsp;&nbsp;&nbsp;An iterable-like hasPrev() function.

_Returns_: (Toybox::Lang::Boolean) If instance iteration has previous.

  

------

`next() => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp; An iterable-like next() function. Increments `stepcount` instance variable.

_Returns_: (Colors::rgb) The rgb at next step;

  

------

`prev() => Colors::rgb`

&nbsp;&nbsp;&nbsp;&nbsp; An iterable-like prev() function. Decrements `stepcount` instance variable.

_Returns_: (Colors::rgb) The rgb at previous step;

  

------

`getStep() => Toybox::Lang::Number`

_Returns_: (Toybox::Lang::Number) Current iteration step count.

  

------

`size() => Toybox::Lang::Number`

_Returns_: (Toybox::Lang::Number) Number of total steps in gradient.

  

------

`get(i) => Colors::rgb`

_Parameters_:

- `i` (Toybox::Lang::Number) - Index of desired value.

  

_Returns_: (Colors::rgb) Color in gradient at given index.
