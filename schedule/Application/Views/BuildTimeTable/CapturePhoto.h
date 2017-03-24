//
//  CapturePhoto.h
//  schedule
//
//  Created by Prince on 7/14/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapturePhoto : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;


- (IBAction)onBack:(id)sender;
- (IBAction)onTakePicture:(id)sender;
- (IBAction)onSavePicture:(id)sender;

@end
