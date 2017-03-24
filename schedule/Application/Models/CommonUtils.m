//
//  CommonUtils.m
//


#import "CommonUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CommonUtils

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

// Convert
- (NSMutableArray *)convertNSIndexSetToNSMutableArray:(NSIndexSet *)indexSet {
    NSMutableArray *result = [NSMutableArray array];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [result addObject:[NSNumber numberWithInteger:idx]];
    }];
    
    return result;
}

- (NSIndexSet *)convertNSArrayToNSIndexSet:(NSArray *)array{
    NSMutableIndexSet *result = [[NSMutableIndexSet alloc] init];

    if (array.count == 0)
        return ([NSIndexSet indexSet]);
    NSUInteger index;
    for (id obj in array) {
        index = [obj integerValue];
        [result addIndex: index];
    }
    
    return result;
}

// Save & Load (NSUserDefaults)
- (void)saveNSArray:(NSArray *)array withKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:array forKey:key];
}

- (NSArray *)loadNSArray:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *result = [userDefaults objectForKey:key];
    return result;
}

- (void)saveNSIndexSet:(NSIndexSet *)indexSet withKey:(NSString *)key {
    NSArray *array = [self convertNSIndexSetToNSMutableArray:indexSet];
    [self saveNSArray:array withKey:key];
    
}

- (NSIndexSet *)loadNSIndexSet:(NSString *)key{
    NSArray *array = [self loadNSArray:key];
    NSIndexSet *result = [self convertNSArrayToNSIndexSet:array];
    return result;
}

- (void)saveNSDictionary:(NSDictionary *)dictionary withKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dictionary forKey:key];
}

- (NSDictionary *)loadNSDictionary:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *result = [userDefaults objectForKey:key];
    return result;
}

- (void)saveNSMutableArray:(NSMutableArray *)mutableArray withKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mutableArray];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}

- (NSMutableArray *)loadNSMutableArray:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:key];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray:array];
    return result;
}

- (NSInteger)getDayOfWeek {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"c"]; // day number, like 7 for saturday
    NSString *strDayOfWeek = [formatter stringFromDate:[NSDate date]];
    NSInteger intDayOfWeek = [strDayOfWeek integerValue];
    return intDayOfWeek - 1;
}

- (NSDate *)getTime {
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *current_time = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    return current_time;
}

- (BOOL)isClassTime:(NSDate *)current_time start:(NSDate *)start_time end:(NSDate *)end_time {
    if (current_time == nil || start_time == nil || end_time == nil)
        return NO;
    
    NSDateComponents *current_components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:current_time];
    NSInteger currentHour = [current_components hour];
    NSInteger currentMinute = [current_components minute];
    NSInteger currentTime = currentHour * 60 + currentMinute;

    NSDateComponents *start_components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:start_time];
    NSInteger startHour = [start_components hour];
    NSInteger startMinute = [start_components minute];
    NSInteger startTime = startHour * 60 + startMinute;
    
    NSDateComponents *end_components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:end_time];
    NSInteger endHour = [end_components hour];
    NSInteger endMinute = [end_components minute];
    NSInteger endTime = endHour * 60 + endMinute;
    
    if (currentTime >= startTime && currentTime <= endTime)
        return YES;
    else
        return NO;
}

- (void)saveImage:(NSString *)name image:(UIImage*)image {
    if (image != nil) {
        NSTimeInterval seconds = [NSDate timeIntervalSinceReferenceDate];
        NSString *filename = [name stringByAppendingString:[NSString stringWithFormat:@"_%ld.png", lround(seconds)]];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", filename]];
        
        NSLog(@"%@", path);
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}

- (NSMutableArray *)loadImage:(NSString*)name {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:documentsDirectory];
    
    NSString *documentsSubpath;
    while (documentsSubpath = [direnum nextObject]) {
        NSInteger location = [documentsSubpath.lastPathComponent rangeOfString:name].location;
        if (location == 0) {
            NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", documentsSubpath.lastPathComponent]];

            [result addObject:path];
        }
    }

    return result;
}


//Alert
- (void)showAlert:(NSString *)title withMessage:(NSString *)message withViewController:(UIViewController *)vc{
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:nil];
    [alert addAction:ok];
    
    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)showVAlertSimple:(NSString *)title body:(NSString *)body duration:(float)duration {
    _dicAlertContent = [[NSMutableDictionary alloc] init];
    [_dicAlertContent setObject:title forKey:@"title"];
    [_dicAlertContent setObject:body forKey:@"body"];
    [_dicAlertContent setObject:[NSString stringWithFormat:@"%f", duration] forKey:@"duration"];
    
    [self performSelector:@selector(vAlertSimpleThread) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
}
-(void)vAlertSimpleThread{
    [appController.vAlert doAlert:[_dicAlertContent objectForKey:@"title"] body:[_dicAlertContent objectForKey:@"body"] duration:[[_dicAlertContent objectForKey:@"duration"] floatValue] done:^(DoAlertView *alertView) {}];
}

@end
