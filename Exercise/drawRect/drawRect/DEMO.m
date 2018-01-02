//
//  DEMO.m
//  drawRect
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/12/25.
//  Copyright © 2017年 深圳前海全民健康科技股份有限公司. All rights reserved.
//

#import "DEMO.h"

#import <UIKit/UIKit.h>

@interface DEMO () {
    CGPoint  _points[200];
}

@end

@implementation DEMO

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        for (int i = 0; i < 200; i ++) {
            CGPoint p = CGPointMake(i * 1, 100+i);
            _points[i] = p;
        }
        
        
//        [self setNeedsDisplay];
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat lineWidth = 1.0;
    // 线条颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    // 设置线条平滑，不需要两边像素宽
    //        context.setShouldAntialias(false)
    // 设置线条宽度
    CGContextSetLineWidth(ctx, lineWidth);
    // 添加路径
    CGContextAddLines(ctx, _points, 200);
    
    // 开始画线
    CGContextStrokePath(ctx);
    
    
    CGContextClearRect(ctx, CGRectMake(0, 0, 20, 500));
    
}

@end
