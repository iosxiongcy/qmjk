//
//  ViewController.m
//  drawRect
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/12/25.
//  Copyright © 2017年 深圳前海全民健康科技股份有限公司. All rights reserved.
//

#import "ViewController.h"

#import "DEMO.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    DEMO *d = [[DEMO alloc] init];
    d.frame = self.view.bounds;
    [self.view.layer addSublayer:d];
    [d setNeedsDisplay];
}



@end
