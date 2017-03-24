//  CommonUtils.h
//  Created by BE

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject{
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, strong) NSMutableDictionary *dicAlertContent;

+ (instancetype)shared;


- (NSMutableArray *)convertNSIndexSetToNSMutableArray:(NSIndexSet *)nsIndexSet;
- (NSIndexSet *)convertNSArrayToNSIndexSet:(NSArray *)array;


// Save & Load
- (void)saveNSArray:(NSArray *)array withKey:(NSString *)key;
- (void)saveNSIndexSet:(NSIndexSet *)indexSet withKey:(NSString *)key;
- (void)saveNSDictionary:(NSDictionary *)dictionary withKey:(NSString *)key;
- (void)saveNSMutableArray:(NSMutableArray *)mutableArray withKey:(NSString *)key;

- (NSArray *)loadNSArray:(NSString *)key;
- (NSIndexSet *)loadNSIndexSet:(NSString *)key;
- (NSDictionary *)loadNSDictionary:(NSString *)key;
- (NSMutableArray *)loadNSMutableArray:(NSString *)key;

// Date & Time
- (NSInteger)getDayOfWeek;
- (NSDate *)getTime;
- (BOOL)isClassTime:(NSDate *)current_time start:(NSDate *)start_time end:(NSDate *)end_time;

// Image
- (void)saveImage:(NSString *)name image:(UIImage*)image;
- (NSMutableArray *)loadImage:(NSString*)name;
//Alert
- (void)showAlert:(NSString *)title withMessage:(NSString *)message withViewController:(UIViewController *)vc;
- (void)showVAlertSimple:(NSString *)title body:(NSString *)body duration:(float)duration;

@end