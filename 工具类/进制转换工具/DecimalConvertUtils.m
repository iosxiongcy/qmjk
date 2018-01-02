//
//  DecimalConvertUtils.m
//  QmjkSDKDemo
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/8/30.
//  Copyright © 2017年 深圳前海全民健康科技股份有限公司. All rights reserved.
//

#import "DecimalConvertUtils.h"

@implementation DecimalConvertUtils

// 16进制转10进制
+ (NSNumber *)numberHexString:(NSString *)aHexString
{
    // 为空,直接返回.
    if (nil == aHexString) return nil;
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    //将整数转换为NSNumber,存储到数组中,并返回.
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    return hexNumber;
}

//10进制转16进制
+ (NSString *)toHex:(long long int)tmpid {
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i =0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}

//二进制转十进制
+ (NSString *)toDecimalWithBinary:(NSString *)binary {
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}

//十进制转二进制
+ (NSString *)toBinaryWithDecimal:(NSInteger)decimal {
    NSInteger num = decimal;//[decimal intValue];
    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%ld",(long)remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    NSString * result = @"";
    for (NSInteger i = prepare.length - 1; i >= 0; i --)
    {
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}

// 16进制转2进制
+ (NSString *)toBinaryWithHex:(NSString *)hexString {
    NSString *result = @"";
    //1. 16进制->10进制
    NSNumber *decNum = [self numberHexString:hexString];
    
    //2. 10进制->2进制
    result = [self toBinaryWithDecimal:[decNum integerValue]];
    
    //3. 补位
    NSUInteger resultLength = result.length, hexLength = hexString.length * 4;
    if (resultLength < hexLength) {
        for (int i = 0; i < hexLength - resultLength; i ++) {
            result = [NSString stringWithFormat:@"0%@", result];
        }
    }
    
    return result;
}

// 2进制转16进制
+ (NSString *)toHexWithBinary:(NSString *)binary {
    NSString *result = @"";
    //1. 2进制->10进制
    NSString *decimal = [self toDecimalWithBinary:binary];
    
    //2. 10进制->16进制
    result = [self toHex:[decimal longLongValue]];
    
    return result;
}

// 二进制补码->原码
+ (NSString *)binaryAdd1:(NSString *)binary {
    
    /// 二进制取反
    NSString *fanStr = @"";
    for (int i = 0; i < binary.length; i ++) {
        NSString *s = [binary substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"0"]) {
            s = @"1";
        } else if ([s isEqualToString:@"1"]) {
            s = @"0";
        }
        fanStr = [fanStr stringByAppendingString:s];
    }
    
    /// 二进制+1
    NSString *result = fanStr;
    NSInteger length = result.length;
    for (int i = (int)length - 1; i >= 0; i --) {
        NSString *s = [result substringWithRange:NSMakeRange(i, 1)];
        if ([s isEqualToString:@"0"]) {
            NSString *one = [result substringWithRange:NSMakeRange(0, i)];
            NSString *two = [result substringWithRange:NSMakeRange(i, length-i-1)];
            s = @"1";
            return [NSString stringWithFormat:@"%@%@%@", one, s, two];
        } else if ([s isEqualToString:@"1"]) {
            NSString *one = [result substringWithRange:NSMakeRange(0, i-1)];
            NSString *two = [result substringWithRange:NSMakeRange(i+1, length-i-1)];
            NSString *lessI = [result substringWithRange:NSMakeRange(i-1, 1)];
            if (!one.length) {
                one = @"";
            }
            if (!two.length) {
                two = @"";
            }
            s = @"0";
            if ([lessI isEqualToString:@"0"]) {
                lessI = @"1";
                return [NSString stringWithFormat:@"%@%@%@%@", one, lessI, s, two];
            } else if ([lessI isEqualToString:@"1"]) {
                //                lessI = @"0";
            }
            result = [NSString stringWithFormat:@"%@%@%@%@", one, lessI, s, two];
        }
    }
    
    return result;
}

@end
