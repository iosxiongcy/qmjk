//
//  WebViewController.m
//  ExerciseLoadHTML
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2018/1/2.
//  Copyright © 2018年 深圳前海全民健康科技股份有限公司. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"UIWebView-JavaScriptCore";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    //    htmlURL = [NSURL URLWithString:@"http://www.baidu.com"];
    NSLog(@"%@", htmlURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    
    self.webView.backgroundColor = [UIColor clearColor];
    // UIWebView 滚动的比较慢，这里设置为正常速度
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}


@end
