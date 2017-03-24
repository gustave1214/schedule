//
//  ClassObject.m
//  schedule
//
//  Created by Prince on 7/14/16.
//  Copyright © 2016 Pavel. All rights reserved.
//

#import "ClassObject.h"

@implementation ClassObject

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.className forKey:@"class_name"];
    [encoder encodeObject:self.weekday   forKey:@"weekday"];
    [encoder encodeObject:self.startTime forKey:@"start_time"];
    [encoder encodeObject:self.endTime   forKey:@"end_time"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self) {
        self.className = [decoder decodeObjectForKey:@"class_name"];
        self.weekday   = [decoder decodeObjectForKey:@"weekday"];
        self.startTime = [decoder decodeObjectForKey:@"start_time"];
        self.endTime   = [decoder decodeObjectForKey:@"end_time"];
    }
    
    return self;
}

@end
