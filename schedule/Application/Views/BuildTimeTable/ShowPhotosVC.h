//
//  ShowPhotosVC.h
//  schedule
//
//  Created by Prince on 7/14/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPhotosVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    DownPicker *downPicker;
}

@property (weak, nonatomic) IBOutlet UITextField *txtSubject;
@property (weak, nonatomic) IBOutlet UITableView *photoTable;

- (IBAction)onBack:(id)sender;

@end
