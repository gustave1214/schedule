//
//  CreateTableVC.m
//  schedule
//
//  Created by Prince on 5/30/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import "CreateTableVC.h"
#import "ClassCell.h"
#import "ClassObject.h"

@interface CreateTableVC () {
    NSMutableArray *classes;
    NSArray *studingDaysArray;
    NSInteger hr, min;
    
    NSInteger selectedClassIndex;
    NSInteger selectedClassWeekDay;
    
    NSString *selectedClassName;
    NSDate *selectedStartTime;
    NSDate *selectedEndTime;
}

@end

@implementation CreateTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Load data
    NSDictionary *selectedDays = [commonUtils loadNSDictionary:@"selectedDays"];
    studingDaysArray = selectedDays[@"studingDays"];
    NSIndexSet *studingDays = [commonUtils convertNSArrayToNSIndexSet:studingDaysArray];
    hr = [selectedDays[@"hour"] integerValue];
    min = [selectedDays[@"minute"] integerValue];
    
    classes = [commonUtils loadNSMutableArray:@"timeTable"];
    if ([classes count] == 0) {
        classes = [[NSMutableArray alloc] init];
        for (int i = 0; i < 56; i++) {
            ClassObject *classObject = [[ClassObject alloc] init];
            classObject.className = @"";
            classObject.weekday = [NSNumber numberWithInt:-1];
            classObject.startTime = [NSDate date];
            classObject.endTime = [NSDate date];
            [classes addObject:classObject];
        }
        [commonUtils saveNSMutableArray:classes withKey:@"timeTable"];
        
    }
    
    // init MultiSelectSegment
    [self.multiDays setSelectedSegmentIndexes:studingDays];
    [self.multiDays setEnabled:false];
    
    // init CollectionView
    self.timeTableCollectionView.delegate = self;
    self.timeTableCollectionView.dataSource = self;
    
    // init Add View
    // Class name Down Picker
    NSArray *subjects = appController.subjects;
    downPicker = [[DownPicker alloc] initWithTextField:self.txtClass withData:subjects];
    
    // Start Time Picker
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeTime;
    datePicker.minuteInterval = 5;
    [self.txtStart setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space, doneBtn, nil]];
    [self.txtStart setInputAccessoryView:toolBar];
    
    self.viewAddClass.hidden = YES;
}

#pragma DatePicker Selector
-(void)ShowSelectedDate {
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    selectedStartTime = datePicker.date;
    selectedEndTime = [selectedStartTime dateByAddingTimeInterval:(hr * 3600 + min * 60)];
    
    self.txtStart.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:selectedStartTime]];
    self.txtEnd.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:selectedEndTime]];
    
    [self.txtStart resignFirstResponder];
}

#pragma CollectionView DataSource and Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return classes.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ClassCell";
    
    ClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    ClassObject *classObject = [classes objectAtIndex:indexPath.row];
    [cell.classLabel setText:classObject.className];
    
    return cell;
}

//select cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger remainder = indexPath.row % 7;

    if ([studingDaysArray containsObject:[NSNumber numberWithInteger:remainder]]) {
        selectedClassIndex = indexPath.row;
        selectedClassWeekDay = remainder;
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"HH:mm"];
        ClassObject *classObject = [classes objectAtIndex:selectedClassIndex];
        [self.txtClass setText:classObject.className];
        self.txtStart.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:classObject.startTime]];
        self.txtEnd.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:classObject.endTime]];
        
        self.viewAddClass.hidden = NO;
    } else {
        selectedClassIndex = -1;
        [commonUtils showVAlertSimple:@"Warning" body:@"You can't add a class." duration:1.0f];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(self.timeTableCollectionView.frame.size.width/7.0f, self.timeTableCollectionView.frame.size.height/8.0f);
}


- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onOk:(id)sender {
    NSString *className = self.txtClass.text;
    
    ClassObject *classObject = [[ClassObject alloc] init];
    classObject.className = className;
    classObject.weekday   = [NSNumber numberWithInteger:selectedClassWeekDay];
    classObject.startTime = selectedStartTime;
    classObject.endTime   = selectedEndTime;
    
    [classes replaceObjectAtIndex:selectedClassIndex withObject:classObject];
    [self.timeTableCollectionView reloadData];
    
    [commonUtils saveNSMutableArray:classes withKey:@"timeTable"];
    
    self.viewAddClass.hidden = YES;
}

- (IBAction)onCancel:(id)sender {
    [self.timeTableCollectionView reloadData];
    self.viewAddClass.hidden = YES;
}

- (IBAction)onNext:(id)sender {
    CapturePhoto *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CapturePhoto"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onViewPhotos:(id)sender {
    ShowPhotosVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowPhotosVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
