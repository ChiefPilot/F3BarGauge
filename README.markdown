F3BarGauge
==========

Welcome!
--------
This demo contains the bar gauge control for iOS.   It has been
tested on iOS 4.x and 5.x on iTouch, iPhone, and iPad devices.

![Screenshot](https://raw.github.com/ChiefPilot/F3BarGauge/master/F3BarGauge.png "Screenshot of Component Demo App")

If you find this control of use (or find bugs), I'd love to hear
from you!   Drop a note to brad@flightiii.com with questions, comments, 
or dissenting opinions.


Background
----------
This control is intended to replicate/simulate the level indicator
on an audio mixing board.   These indicators are usually 
segmented/stacked LEDs, with several colors to indicate thresholds.
This control replicates that look, using Quartz drawing primitives,
and auto-adjusts to horizontal or vertical orientation. Additionally, 
the colors, number of bars, peak hold, and other items are easily 
customizable. 


Usage
-----
Adding this control to your XCode project is straightforward :
1.  Add the F3BarGauge.h and F3BarGauge.m files to your project
2.  Add a new blank subview to the nib, sized and positioned to 
    match what the bar gauge should look like.
3.  In the properties inspector for this subview, change the
    class to "F3BarGauge"
4.  Add an outlet to represent the bar gauge
5.  Update your code to set the value property as appropriate.

The demo code has multiple examples, including a version that
customizes the gauge to look like an LCD flavor that looks cool
for showing temperatures or fan speeds, for example.

License
-------
Copyright (c) 2011 by Brad Benson
All rights reserved.
  
Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following 
conditions are met:
  1.  Redistributions of source code must retain the above copyright
      notice this list of conditions and the following disclaimer.
  2.  Redistributions in binary form must reproduce the above copyright 
      notice, this list of conditions and the following disclaimer in 
      the documentation and/or other materials provided with the 
      distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
OF SUCH DAMAGE.
