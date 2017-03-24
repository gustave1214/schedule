//
//  SetDaysVC.h
//  schedule
//
//  Created by Prince on 5/30/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetDaysVC : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate>


@property (weak, nonatomic) IBOutlet MultiSelectSegmentedControl *multiDays;

@property (weak, nonatomic) IBOutlet UIPickerView *hoursPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *minutesPicker;

@property (weak, nonatomic) IBOutlet UITextField *hourTextField;
@property (weak, nonatomic) IBOutlet UITextField *minuteTextField;

- (IBAction)onHour:(id)sender;
- (IBAction)onMinute:(id)sender;
- (IBAction)onNext:(id)sender;

@end
