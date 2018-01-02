//
//  NSObject+print.h
//  测试类别的属性和成员变量
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/12/6.
//  Copyright © 2017年 深圳前海全民健康科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (print)

#pragma mark - Log
#pragma mark ivars
- (void)logIvars;
- (void)logCustomIvars;
- (void)logIvarsWithExpReg:(NSString *)expReg;
- (void)logCustomIvarsWithExpReg:(NSString *)expReg;

#pragma mark properties
- (void)logProperties;
- (void)logCustomProperties;
- (void)logPropertiesWithExpReg:(NSString *)expReg;
- (void)logCustomPropertiesWithExpReg:(NSString *)expReg;

#pragma mark method
- (void)logMethods;
- (void)logCustomMethods;
- (void)logMethodsWithExpReg:(NSString *)expReg;
- (void)logCustomMethodsWithRxpReg:(NSString *)expReg;

@end
