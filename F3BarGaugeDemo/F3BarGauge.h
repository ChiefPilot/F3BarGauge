//
//  F3BarGauge.h
//
//  Copyright (c) 2011-2014 by Brad Benson
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without 
//  modification, are permitted provided that the following 
//  conditions are met:
//    1.  Redistributions of source code must retain the above copyright
//        notice this list of conditions and the following disclaimer.
//    2.  Redistributions in binary form must reproduce the above copyright 
//        notice, this list of conditions and the following disclaimer in 
//        the documentation and/or other materials provided with the 
//        distribution.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
//  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
//  COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
//  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
//  AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
//  THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY 
//  OF SUCH DAMAGE.
//  

//---> Pick up required headers <-----------------------------------------
#import <UIKit/UIKit.h>


//------------------------------------------------------------------------
//------------------------------------------------------------------------
//------------------|  F3BarGauge class definition  |---------------------
//------------------------------------------------------------------------
//------------------------------------------------------------------------
@interface F3BarGauge : UIView

@property (readwrite, nonatomic)  float     value;
@property (readwrite, nonatomic)  float     warnThreshold;
@property (readwrite, nonatomic)  float     dangerThreshold;
@property (readwrite, nonatomic)  float     maxLimit;
@property (readwrite, nonatomic)  float     minLimit;
@property (readwrite, nonatomic)  int       numBars;
@property (readonly, nonatomic)   float     peakValue;
@property (readwrite, nonatomic)  BOOL      holdPeak;
@property (readwrite, nonatomic)  BOOL      litEffect;
@property (readwrite, nonatomic)  BOOL      reverse;
@property (readwrite, strong)     UIColor   *outerBorderColor;
@property (readwrite, strong)     UIColor   *innerBorderColor;
@property (readwrite, strong)     UIColor   *backgroundColor;
@property (readwrite, strong)     UIColor   *normalBarColor;
@property (readwrite, strong)     UIColor   *warningBarColor;
@property (readwrite, strong)     UIColor   *dangerBarColor;

-(void) resetPeak;



@end
