//
//  F3BarGauge.m
//
//  Copyright (c) 2011 by Brad Benson
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


// Pick up required headers
#import "F3BarGauge.h"



//------------------------------------------------------------------------
//------------------------------------------------------------------------
//---------------|  F3BarGauge class implementation  |--------------------
//------------------------------------------------------------------------
//------------------------------------------------------------------------

//===[ Extention for private-ish stuff ]==================================
@interface F3BarGauge()
{
  @private
    int             m_iOnIdx,               // Point at which segments are on
                    m_iOffIdx,              // Point at which segments are off
                    m_iPeakBarIdx,          // Index of peak value segment
                    m_iWarningBarIdx,       // Index of first warning segment
                    m_iDangerBarIdx;        // Index of first danger segment
}

// Private methods
-(void) setDefaults;
-(void) drawBar:(CGContextRef)a_ctx
       withRect:(CGRect) a_rect
       andColor:(UIColor *)a_clr
            lit:(BOOL)a_lit;
@end



@implementation F3BarGauge
//===[ Public Methods ]===================================================

//------------------------------------------------------------------------
//  Method: initWithFrame:
//    Designated initializer
//
-(id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self) {
    // Assign default values
    [self setDefaults];
  }
  return self;
}


//------------------------------------------------------------------------
// Method:  initWithCoder:
//  Initializes the instance when brought from nib, etc.
//
-(id) initWithCoder:(NSCoder *)aDecoder
{ 
  self = [super initWithCoder:aDecoder];
  if(self) {
    // Assign default values
    [self setDefaults];
  }
  return self;
}


//------------------------------------------------------------------------
//  Method: dealloc
//    Clean up instance when released
//
-(void) dealloc
{
  // Clean up
  [m_clrBackground release];
  [m_clrOuterBorder release];
  [m_clrInnerBorder release];
  [m_clrNormal release];
  [m_clrWarning release];
  [m_clrDanger release];
  
  // Call parent
  [super dealloc];
}


//------------------------------------------------------------------------
//  Method: resetPeak
//    Resets peak value.  
//
-(void) resetPeak
{
  // Reset the value and redraw
  m_flPeakValue = -INFINITY;
  m_iPeakBarIdx = -1;
  [self setNeedsDisplay];
}


//------------------------------------------------------------------------
//  Method: value accessor
//
-(float) value
{
  return m_flValue;
}


//------------------------------------------------------------------------
//  Method: value setter
//
-(void) setValue:(float)a_value
{
  bool      fRedraw = false;
  
  // Save value
  m_flValue = a_value;
  
  // Point at which bars start lighting up
  int iOnIdx = (m_flValue >= m_flMinLimit) ?  0 : m_iNumBars;
  if( iOnIdx != m_iOnIdx ) {
    // Changed - save it
    m_iOnIdx = iOnIdx;
    fRedraw = true;
  }
  
  // Point at which bars are no longer lit
  int iOffIdx = ((m_flValue - m_flMinLimit) / (m_flMaxLimit - m_flMinLimit)) * m_iNumBars;
  if( iOffIdx != m_iOffIdx ) {
    // Changed - save it
    m_iOffIdx = iOffIdx;
    fRedraw = true;
  }
  
  // Are we doing peak?
  if( m_fHoldPeak && a_value > m_flPeakValue ) {
    // Yes, save the peak bar index
    m_flPeakValue = a_value;
    m_iPeakBarIdx = MIN(m_iOffIdx, m_iNumBars - 1);
  }
  
  // Redraw the display?
  if( fRedraw ) {
    // Do it
    [self setNeedsDisplay];
  }
}


//------------------------------------------------------------------------
//  Method: setNumBars:
//    This method sets the number of bars in the display
//
- (void) setNumBars:(int)a_iNumBars
{
  // Reset peak value to force it to be updated w/new bar index
  m_flPeakValue = -INFINITY;
  
  // Save it, then update the thresholds
  m_iNumBars = a_iNumBars;
  [self setValue:m_flValue];
  [self setWarnThreshold:m_flWarnThreshold];
  [self setDangerThreshold:m_flDangerThreshold];
}


//------------------------------------------------------------------------
//  Method: setWarnThreshold:
//    Sets the level for which bars should be of the warning color
//    (dft: yellow)
//
- (void) setWarnThreshold:(float)a_flWarnThreshold
{
  // Save it and recompute values
  m_flWarnThreshold = a_flWarnThreshold;
  m_iWarningBarIdx = ( !isnan(a_flWarnThreshold) && a_flWarnThreshold > 0.0f ) ?
                                (int)( m_flWarnThreshold * (float)m_iNumBars ) :
                                -1;
}


//------------------------------------------------------------------------
//  Method: setDangerThreshold:
//    Sets the level for which bars should be of the warning color
//    (dft: red).
//
- (void) setDangerThreshold:(float)a_flDangerThreshold
{
  // Save it and recompute values
  m_flDangerThreshold = a_flDangerThreshold;
  m_iDangerBarIdx = ( !isnan(a_flDangerThreshold) && a_flDangerThreshold > 0.0f ) ?
                                (int)( m_flDangerThreshold * (float)m_iNumBars ) :
                                -1;
}


//------------------------------------------------------------------------
//  Synthesized properties
//
@synthesize maxLimit = m_flMaxLimit;
@synthesize minLimit = m_flMinLimit;
@synthesize numBars = m_iNumBars;
@synthesize warnThreshold = m_flWarning;
@synthesize dangerThreshold = m_flDanger;
@synthesize holdPeak = m_fHoldPeak;
@synthesize peakValue = m_flPeakValue;
@synthesize litEffect = m_fLitEffect;
@synthesize reverse = m_fReverseDirection;
@synthesize outerBorderColor = m_clrOuterBorder;
@synthesize innerBorderColor = m_clrInnerBorder;
@synthesize backgroundColor = m_clrBackground;
@synthesize normalBarColor = m_clrNormal;
@synthesize warningBarColor = m_clrWarning;
@synthesize dangerBarColor = m_clrDanger;



//===[ Private Methods ]==================================================

//------------------------------------------------------------------------
//  Method: setDefaults
//    Configure default settings for instance
//
-(void) setDefaults
{
  // Set view background to clear
  [self setBackgroundColor:[UIColor clearColor]];
  
  // Configure limits
  m_flMaxLimit  = 1.0f;
  m_flMinLimit  = 0.0f;
  m_flValue     = 0.0f;
  
  // Set defaults for bar display
  m_fHoldPeak         = NO;
  m_iNumBars          = 10;
  m_iOffIdx           = 0;
  m_iOnIdx            = 0;
  m_iPeakBarIdx       = -1;
  m_fLitEffect        = YES;
  m_fReverseDirection = NO;
  [self setWarnThreshold:0.60f];
  [self setDangerThreshold:0.80f];
  
  // Set default colors
  m_clrBackground       = [[UIColor blackColor] retain];
  m_clrOuterBorder      = [[UIColor grayColor] retain];
  m_clrInnerBorder      = [[UIColor blackColor] retain];
  m_clrNormal           = [[UIColor greenColor] retain];
  m_clrWarning          = [[UIColor yellowColor] retain];
  m_clrDanger           = [[UIColor redColor] retain];
  
  // Misc.
  self.clearsContextBeforeDrawing = NO;
  self.opaque = NO;
}


//------------------------------------------------------------------------
//  Method: drawRect:
//    Draw the gauge
//
-(void) drawRect:(CGRect)rect
{
  CGContextRef        ctx;          // Graphics context
  CGRect              rectBounds,   // Bounding rectangle adjusted for multiple of bar size
                      rectBar;      // Rectangle for individual light bar
  size_t              iBarSize;     // Size (width or height) of each LED bar

  // How is the bar oriented?
  rectBounds = self.bounds;
  BOOL fIsVertical = (rectBounds.size.height >= rectBounds.size.width);
  if(fIsVertical) {
    // Adjust height to be an exact multiple of bar 
    iBarSize = rectBounds.size.height / m_iNumBars;
    rectBounds.size.height  = iBarSize * m_iNumBars;
  }
  else {
    // Adjust width to be an exact multiple
    iBarSize = rectBounds.size.width / m_iNumBars;
    rectBounds.size.width = iBarSize * m_iNumBars;
  }
  
  // Compute size of bar
  rectBar.size.width  = (fIsVertical) ? rectBounds.size.width - 2 : iBarSize;
  rectBar.size.height = (fIsVertical) ? iBarSize : rectBounds.size.height - 2;
  
  // Get stuff needed for drawing
  ctx = UIGraphicsGetCurrentContext();
  CGContextClearRect(ctx, self.bounds); 
  
  // Fill background
  CGContextSetFillColorWithColor(ctx, m_clrBackground.CGColor);
  CGContextFillRect(ctx, rectBounds);

  // Draw LED bars
  CGContextSetStrokeColorWithColor(ctx, m_clrInnerBorder.CGColor);
  CGContextSetLineWidth(ctx, 1.0);
  for( int iX = 0; iX < m_iNumBars; ++iX ) {
    // Determine position for this bar
    if(m_fReverseDirection) {
      // Top-to-bottom or right-to-left
      rectBar.origin.x = (fIsVertical) ? rectBounds.origin.x + 1 : (CGRectGetMaxX(rectBounds) - (iX+1) * iBarSize);
      rectBar.origin.y = (fIsVertical) ? (CGRectGetMinY(rectBounds) + iX * iBarSize) : rectBounds.origin.y + 1;
    }
    else {
      // Bottom-to-top or right-to-left
      rectBar.origin.x = (fIsVertical) ? rectBounds.origin.x + 1 : (CGRectGetMinX(rectBounds) + iX * iBarSize);
      rectBar.origin.y = (fIsVertical) ? (CGRectGetMaxY(rectBounds) - (iX + 1) * iBarSize) : rectBounds.origin.y + 1;
    }
    
    // Draw top and bottom borders for bar
    CGContextAddRect(ctx, rectBar);
    CGContextStrokePath(ctx);

    // Determine color of bar
    UIColor   *clrFill = m_clrNormal;
    if( m_iDangerBarIdx >= 0 && iX >= m_iDangerBarIdx ) {
      clrFill = m_clrDanger;
    }
    else if( m_iWarningBarIdx >= 0 && iX >= m_iWarningBarIdx ) {
      clrFill = m_clrWarning;
    }
    
    // Determine if bar should be lit
    BOOL fLit = ((iX >= m_iOnIdx && iX < m_iOffIdx) || iX == m_iPeakBarIdx);
    
    // Fill the interior of the bar
    CGContextSaveGState(ctx);
    CGRect rectFill = CGRectInset(rectBar, 1.0, 1.0);
    CGPathRef clipPath = CGPathCreateWithRect(rectFill, NULL);
    CGContextAddPath(ctx, clipPath);
    CGContextClip(ctx);
    [self drawBar:ctx 
         withRect:rectFill 
         andColor:clrFill 
              lit:fLit];
    CGContextRestoreGState(ctx);
    CGPathRelease(clipPath);
  }
  
  // Draw border around the control
  CGContextSetStrokeColorWithColor(ctx, m_clrOuterBorder.CGColor);
  CGContextSetLineWidth(ctx, 2.0);
  CGContextAddRect(ctx, CGRectInset(rectBounds, 1, 1));
  CGContextStrokePath(ctx);
}


//------------------------------------------------------------------------
//  Method: drawBar::::
//    This method draws a bar
//
- (void) drawBar:(CGContextRef)a_ctx 
        withRect:(CGRect)a_rect
        andColor:(UIColor *)a_clr
             lit:(BOOL) a_fLit
{
  // Is the bar lit?
  if(a_fLit) {
    // Are we doing radial gradient fills?
    if(m_fLitEffect) {
      // Yes, set up to draw the bar as a radial gradient
      static  size_t  num_locations = 2;
      static  CGFloat locations[]   = { 0.0, 0.5 };
      CGFloat aComponents[8];
      CGColorRef clr = a_clr.CGColor;
      
      // Set up color components from passed UIColor object
      if (CGColorGetNumberOfComponents(clr) == 4) {
        // Extract the components
        //
        //  Note that iOS 5.0 provides a nicer way to do this i.e.
        //    [a_clr getRed:&aComponents[0] 
        //            green:&aComponents[1] 
        //             blue:&aComponents[2] 
        //            alpha:&aComponents[3] ];
        memcpy(aComponents, CGColorGetComponents(clr), 4*sizeof(CGFloat));
        
        // Calculate dark color of gradient
        aComponents[4] = aComponents[0] - ((aComponents[0] > 0.3) ? 0.3 : 0.0);
        aComponents[5] = aComponents[1] - ((aComponents[1] > 0.3) ? 0.3 : 0.0);
        aComponents[6] = aComponents[2] - ((aComponents[2] > 0.3) ? 0.3 : 0.0);
        aComponents[7] = aComponents[3];
      }
      
      // Calculate radius needed
      CGFloat width = CGRectGetWidth(a_rect);
      CGFloat height = CGRectGetHeight(a_rect);
      CGFloat radius = sqrt( width * width + height * height );
      
      // Draw the gradient inside the provided rectangle
      CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
      CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, 
                                                                      aComponents, 
                                                                      locations, 
                                                                      num_locations);
      CGPoint myStartPoint = { CGRectGetMidX(a_rect), CGRectGetMidY(a_rect) };
      CGContextDrawRadialGradient(a_ctx, myGradient, myStartPoint, 0.0, myStartPoint, radius, 0);
      CGColorSpaceRelease(myColorspace);
      CGGradientRelease(myGradient);
    }
    else {
      // No, solid fill
      CGContextSetFillColorWithColor(a_ctx, a_clr.CGColor);
      CGContextFillRect(a_ctx, a_rect);
    }
  }
  else {
    // No, draw the bar as background color overlayed with a mostly
    // ... transparent version of the passed color
    CGColorRef  fillClr = CGColorCreateCopyWithAlpha(a_clr.CGColor, 0.2f);
    CGContextSetFillColorWithColor(a_ctx, m_clrBackground.CGColor);
    CGContextFillRect(a_ctx, a_rect);
    CGContextSetFillColorWithColor(a_ctx, fillClr);
    CGContextFillRect(a_ctx, a_rect);
    CGColorRelease(fillClr);  
  }    
}

@end
