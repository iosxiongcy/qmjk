//
//  DecimalConvertUtils.h
//  QmjkSDKDemo
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/8/30.
//  Copyright © 2017年 深圳前海全民健康科技股份有限公司. All rights reserved.
//  进制转换工具类

#import <Foundation/Foundation.h>

@interface DecimalConvertUtils : NSObject

/**
 16进制转10进制
 */
+ (NSNumber *)numberHexString:(NSString *)aHexString;

/**
 10进制转16进制
 */
+ (NSString *)toHex:(long long int)tmpid;

/**
 2进制转10进制
 */
+ (NSString *)toDecimalWithBinary:(NSString *)binary;

/**
 10进制转2进制
 */
+ (NSString *)toBinaryWithDecimal:(NSInteger)decimal;

/**
 16进制转2进制
 */
+ (NSString *)toBinaryWithHex:(NSString *)hexString;

/**
 2进制转16进制
 */
+ (NSString *)toHexWithBinary:(NSString *)binary;


/**
 二进制补码->原码
 */
+ (NSString *)binaryAdd1:(NSString *)binary;


@end
