//
//  ViewController.m
//  F3BarGaugeDemo
//
//  Created by Brad Benson on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize horizontalBar;
@synthesize verticalBar;
@synthesize lcdBar;
@synthesize peakHoldBar;
@synthesize customThresholdBar;
@synthesize customRangeBar;
@synthesize valueSlider;
@synthesize valueLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  customThresholdBar.numBars = 15;
  customThresholdBar.warnThreshold = 0.45;
  customThresholdBar.dangerThreshold = 0.90;
  customThresholdBar.normalBarColor = [UIColor blueColor];
  customThresholdBar.warningBarColor = [UIColor cyanColor];
  customThresholdBar.dangerBarColor = [UIColor magentaColor];
  customThresholdBar.outerBorderColor = [UIColor clearColor];
  customThresholdBar.innerBorderColor = [UIColor clearColor];
  
  customRangeBar.numBars = 20;
  customRangeBar.minLimit = 0.40;
  customRangeBar.maxLimit = 0.60;
  
  peakHoldBar.numBars = 20;
  peakHoldBar.holdPeak = YES;

  lcdBar.numBars = 20;
  lcdBar.litEffect = NO;
  UIColor *clrBar = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
  lcdBar.normalBarColor = clrBar;
  lcdBar.warningBarColor = clrBar;
  lcdBar.dangerBarColor = clrBar;
  lcdBar.backgroundColor = [UIColor clearColor];
  lcdBar.outerBorderColor = [UIColor clearColor];
  lcdBar.innerBorderColor = [UIColor clearColor];
}

- (void)viewDidUnload
{
  [self setCustomThresholdBar:nil];
  [self setCustomRangeBar:nil];
  [self setValueLabel:nil];
  [super viewDidUnload];
  [self setHorizontalBar:nil];
  [self setVerticalBar:nil];
  [self setValueSlider:nil];
  [self setLcdBar:nil];
  [self setPeakHoldBar:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc {
  [horizontalBar release];
  [verticalBar release];
  [valueSlider release];
  [lcdBar release];
  [lcdBar release];
  [peakHoldBar release];
  [customThresholdBar release];
  [customRangeBar release];
  [valueLabel release];
  [super dealloc];
}

- (IBAction)didChangeValue:(id)sender {
  // Update the text label
  valueLabel.text = [NSString stringWithFormat:@"%0.02f", valueSlider.value];
  
  // Update the bar gauges
  horizontalBar.value = valueSlider.value;
  lcdBar.value = valueSlider.value;
  verticalBar.value = valueSlider.value;
  peakHoldBar.value = valueSlider.value;
  customThresholdBar.value = valueSlider.value;
  customRangeBar.value = valueSlider.value;

}

- (IBAction)didReset:(id)sender {
  [peakHoldBar resetPeak];
}
@end
