//
//  SetDaysVC.m
//  schedule
//
//  Created by Prince on 5/30/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import "SetDaysVC.h"

@interface SetDaysVC () {
    NSInteger hr, min;
    NSMutableArray *hours, *minutes;
}

@end

@implementation SetDaysVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hours   = [[NSMutableArray alloc] init];
    minutes = [[NSMutableArray alloc] init];
    for (int i = 0; i < 24; i++) {
        [hours addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    for (int i = 0; i < 60; i += 5) {
        [minutes addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    self.hoursPicker.delegate   = self;
    self.hoursPicker.dataSource = self;
    
    self.minutesPicker.delegate   = self;
    self.minutesPicker.dataSource = self;
    
    self.hoursPicker.hidden   = YES;
    self.minutesPicker.hidden = YES;
    
    UITapGestureRecognizer *hourTapGR   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped)];
    UITapGestureRecognizer *minuteTapGR   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped)];
    hourTapGR.delegate = self;
    minuteTapGR.delegate = self;
    
    [self.hoursPicker   addGestureRecognizer:hourTapGR];
    [self.minutesPicker addGestureRecognizer:minuteTapGR];
    
    NSDictionary *selectedDays = [commonUtils loadNSDictionary:@"selectedDays"];
    NSArray *studingDaysArray = selectedDays[@"studingDays"];
    NSIndexSet *studingDays = [commonUtils convertNSArrayToNSIndexSet:studingDaysArray];
    hr = [selectedDays[@"hour"] integerValue];
    min = [selectedDays[@"minute"] integerValue];
    [self.multiDays setSelectedSegmentIndexes:studingDays];
    self.hourTextField.text = [NSString stringWithFormat:@"%ld", (long)hr];
    self.minuteTextField.text = [NSString stringWithFormat:@"%ld", (long)min];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerView Delegate and DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.hoursPicker]) {
        return hours.count;
    } else {
        return minutes.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:self.hoursPicker]) {
        return [hours objectAtIndex:row];
    } else {
        return [minutes objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([pickerView isEqual:self.hoursPicker]) {
        hr = row;
    } else {
        min = row * 5;
    }
}

- (void)pickerViewTapped {
    self.hourTextField.text = [NSString stringWithFormat:@"%ld", (long)hr];
    self.minuteTextField.text = [NSString stringWithFormat:@"%ld", (long)min];
    
    self.hoursPicker.hidden   = YES;
    self.minutesPicker.hidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}

#pragma Actions
- (IBAction)onHour:(id)sender {
    self.hoursPicker.hidden = NO;
}

- (IBAction)onMinute:(id)sender {
    self.minutesPicker.hidden = NO;
}

- (IBAction)onNext:(id)sender {
    NSMutableDictionary *selectedDays = [[NSMutableDictionary alloc] init];
    
    NSIndexSet *studingDays = [self.multiDays selectedSegmentIndexes];
    
    [selectedDays setObject:[commonUtils convertNSIndexSetToNSMutableArray:studingDays] forKey:@"studingDays"];
    [selectedDays setObject:[NSNumber numberWithInteger:hr]  forKey:@"hour"];
    [selectedDays setObject:[NSNumber numberWithInteger:min]  forKey:@"minute"];
    
    [commonUtils saveNSDictionary:selectedDays withKey:@"selectedDays"];
    
    appController.studingDays = [commonUtils convertNSIndexSetToNSMutableArray:studingDays];
    
    CreateTableVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateTableVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
