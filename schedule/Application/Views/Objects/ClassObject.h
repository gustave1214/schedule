//
//  ClassObject.h
//  schedule
//
//  Created by Prince on 7/14/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassObject : NSObject<NSCoding>

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSNumber *weekday;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

@end
