//
//  CapturePhoto.m
//  schedule
//
//  Created by Prince on 7/14/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import "CapturePhoto.h"

@interface CapturePhoto () {
    NSMutableArray *classes;
    NSArray *subjects;
    UIImage *image;
}

@end

@implementation CapturePhoto

- (void)viewDidLoad {
    [super viewDidLoad];
    
    subjects = appController.subjects;
    
    classes = [commonUtils loadNSMutableArray:@"timeTable"];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onTakePicture:(id)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                        message:@"Device has no camera"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [picker setCameraFlashMode:UIImagePickerControllerCameraFlashModeAuto];
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (IBAction)onSavePicture:(id)sender {
    NSInteger dayOfWeek = [commonUtils getDayOfWeek];
    NSLog(@"Today is: %d", dayOfWeek);
    
    NSDate *current_time = [commonUtils getTime];
    
    for (int i = 0; i < classes.count; i++) {
        ClassObject *classObject = [classes objectAtIndex:i];

        if (classObject.weekday == [NSNumber numberWithInteger:dayOfWeek]) {
            if ([commonUtils isClassTime:current_time start:classObject.startTime end:classObject.endTime]) {
                if (image != nil)
                    [self savePhoto:classObject.className];
                break;
            }
        }
    }
}

- (void)savePhoto:(NSString *)subjectName {
    [commonUtils saveImage:subjectName image:image];
}



#pragma ImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    image = info[UIImagePickerControllerOriginalImage];
    self.imgPicture.image = image;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
