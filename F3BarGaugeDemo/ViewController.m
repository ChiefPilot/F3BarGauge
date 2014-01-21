//
//  ViewController.m
//  F3BarGaugeDemo
//
//  Created by Brad Benson on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet F3BarGauge *horizontalBar;
@property (strong, nonatomic) IBOutlet F3BarGauge *reversedBar;
@property (strong, nonatomic) IBOutlet F3BarGauge *verticalBar;
@property (strong, nonatomic) IBOutlet F3BarGauge *lcdBar;
@property (strong, nonatomic) IBOutlet F3BarGauge *peakHoldBar;
@property (strong, nonatomic) IBOutlet F3BarGauge *customThresholdBar;
@property (strong, nonatomic) IBOutlet F3BarGauge *customRangeBar;
@property (strong, nonatomic) IBOutlet UISlider *valueSlider;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;

- (IBAction)didChangeValue:(id)sender;
- (IBAction)didReset:(id)sender;
@end



@implementation ViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  _reversedBar.reverse = YES;
  
  _customThresholdBar.numBars = 15;
  _customThresholdBar.warnThreshold = 0.45;
  _customThresholdBar.dangerThreshold = 0.90;
  _customThresholdBar.normalBarColor = [UIColor blueColor];
  _customThresholdBar.warningBarColor = [UIColor cyanColor];
  _customThresholdBar.dangerBarColor = [UIColor magentaColor];
  _customThresholdBar.outerBorderColor = [UIColor clearColor];
  _customThresholdBar.innerBorderColor = [UIColor clearColor];
  
  _customRangeBar.numBars = 20;
  _customRangeBar.minLimit = 0.40;
  _customRangeBar.maxLimit = 0.60;
  
  _peakHoldBar.numBars = 10;
  _peakHoldBar.holdPeak = YES;

  _lcdBar.numBars = 20;
  _lcdBar.litEffect = NO;
  UIColor *clrBar = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
  _lcdBar.normalBarColor = clrBar;
  _lcdBar.warningBarColor = clrBar;
  _lcdBar.dangerBarColor = clrBar;
  _lcdBar.backgroundColor = [UIColor clearColor];
  _lcdBar.outerBorderColor = [UIColor clearColor];
  _lcdBar.innerBorderColor = [UIColor clearColor];
}


- (IBAction)didChangeValue:(id)sender {
  // Update the text label
  _valueLabel.text = [NSString stringWithFormat:@"%0.02f", _valueSlider.value];
  
  // Update the bar gauges
  _horizontalBar.value = _valueSlider.value;
  _reversedBar.value = _valueSlider.value;
  _lcdBar.value = _valueSlider.value;
  _verticalBar.value = _valueSlider.value;
  _peakHoldBar.value = _valueSlider.value;
  _customThresholdBar.value = _valueSlider.value;
  _customRangeBar.value = _valueSlider.value;

}

- (IBAction)didReset:(id)sender {
  [_peakHoldBar resetPeak];
}
@end
