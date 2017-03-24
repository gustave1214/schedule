//
//  CreateTableVC.h
//  schedule
//
//  Created by Prince on 5/30/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"

@interface CreateTableVC : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UIDatePicker *datePicker;
    DownPicker *downPicker;
}


@property (weak, nonatomic) IBOutlet MultiSelectSegmentedControl *multiDays;
@property (weak, nonatomic) IBOutlet UICollectionView *timeTableCollectionView;


@property (weak, nonatomic) IBOutlet UIView *viewAddClass;
@property (weak, nonatomic) IBOutlet UITextField *txtClass;
@property (weak, nonatomic) IBOutlet UITextField *txtStart;
@property (weak, nonatomic) IBOutlet UITextField *txtEnd;


- (IBAction)onBack:(id)sender;
- (IBAction)onOk:(id)sender;
- (IBAction)onCancel:(id)sender;
- (IBAction)onNext:(id)sender;
- (IBAction)onViewPhotos:(id)sender;

@end
