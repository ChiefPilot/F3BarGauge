//
//  ViewController.h
//  F3BarGaugeDemo
//
//  Created by Brad Benson on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F3BarGauge.h"

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet F3BarGauge *horizontalBar;
@property (retain, nonatomic) IBOutlet F3BarGauge *reversedBar;
@property (retain, nonatomic) IBOutlet F3BarGauge *verticalBar;
@property (retain, nonatomic) IBOutlet F3BarGauge *lcdBar;
@property (retain, nonatomic) IBOutlet F3BarGauge *peakHoldBar;
@property (retain, nonatomic) IBOutlet F3BarGauge *customThresholdBar;
@property (retain, nonatomic) IBOutlet F3BarGauge *customRangeBar;
@property (retain, nonatomic) IBOutlet UISlider *valueSlider;
@property (retain, nonatomic) IBOutlet UILabel *valueLabel;

- (IBAction)didChangeValue:(id)sender;
- (IBAction)didReset:(id)sender;
@end
