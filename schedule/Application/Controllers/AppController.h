//  AppController.h
//  Created by BE

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppController : NSObject

@property (nonatomic, strong) DoAlertView *vAlert;

// Temporary Variables

@property (nonatomic, strong) NSArray *studingDays;
@property (nonatomic) NSInteger hour, minute;
@property (nonatomic, strong) NSArray *subjects;


+ (AppController *)sharedInstance;

@end