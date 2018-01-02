//
//  NSDate+dateComponent.m
//  本地通知
//
//  Created by healthme009 on 2017/5/16.
//  Copyright © 2017年 healthm. All rights reserved.
//

#import "NSDate+dateComponent.h"
#import <objc/runtime.h>

static char *kHourDynamicPropertyKey   = "hourPropertyKey";
static char *kMinuteDynamicPropertyKey = "minutePropertyKey";
static char *kSecondDynamicPropertyKey = "secondPropertyKey";

@implementation NSDate (dateComponent)

- (NSInteger)hour {
    return [self.times[0] integerValue];
//    return [objc_getAssociatedObject(self, kHourDynamicPropertyKey) integerValue];
}
- (void)setHour:(NSInteger)hour {
    objc_setAssociatedObject(self, kHourDynamicPropertyKey, [NSNumber numberWithInteger:hour], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)minute {
//    return [objc_getAssociatedObject(self, kMinuteDynamicPropertyKey) integerValue];
    return [self.times[1] integerValue];
}
- (void)setMinute:(NSInteger)minute {
    objc_setAssociatedObject(self, kMinuteDynamicPropertyKey, [NSNumber numberWithInteger:minute], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)second {
//    return [objc_getAssociatedObject(self, kSecondDynamicPropertyKey) integerValue];
    return [self.times[2] integerValue];
}
- (void)setSecond:(NSInteger)second {
    objc_setAssociatedObject(self, kSecondDynamicPropertyKey, [NSNumber numberWithInteger:second], OBJC_ASSOCIATION_ASSIGN);
}

- (NSArray *)times {
    NSDateFormatter *dmf = [[NSDateFormatter alloc] init];
    dmf.dateFormat = @"HH:mm:ss";
    NSString *dateString = [dmf stringFromDate:self];
    NSArray *times = [dateString componentsSeparatedByString:@":"];
    return times;
}

@end
