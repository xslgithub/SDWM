//
//  WMBuyDetailsController.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/3.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMBuyDetailsController.h"
#import "UIView+Extension.h"

@interface WMBuyDetailsController ()
@property (nonatomic, strong)UIWebView *webView;


@property (nonatomic, strong)UIWebView *webView1;
@end


@implementation WMBuyDetailsController
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 40, 375, 637)];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}

- (UIWebView *)webView1
{
    if (!_webView1) {
        _webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, 375, 637)];
        _webView1.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.webView1];
    
    NSString *str = [NSString stringWithFormat:@"<html><head><title>Html加载</title></head><body>%@</body></html>", self.buyDetails];
    [self.webView1 loadHTMLString:str baseURL:nil];
    
    if (self.navigationController.navigationBar.alpha >= 0.6) {
        self.webView1.y = 124;
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 187.5, 60)];
        [btn1 setTitle:@"套餐内容" forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor grayColor];
        [self.view addSubview:btn1];
        [btn1 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(187.5, 64, 187.5, 60)];
        [btn2 setTitle:@"店铺详情" forState:UIControlStateNormal];
        btn2.backgroundColor = [UIColor grayColor];
        [self.view addSubview:btn2];
        [btn2 addTarget:self action:@selector(click4) forControlEvents:UIControlEventTouchUpInside];
        
        // 中间的隔线 (* ￣3)(ε￣ *)
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(187.5, 84, 0.3, 25)];
        b.backgroundColor = [UIColor blackColor];
        [self.view addSubview:b];

    } else {
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 187.5, 60)];
        [btn1 setTitle:@"套餐内容" forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor grayColor];
        [self.view addSubview:btn1];
        [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(187.5, 0, 187.5, 60)];
        [btn2 setTitle:@"店铺详情" forState:UIControlStateNormal];
        btn2.backgroundColor = [UIColor grayColor];
        [self.view addSubview:btn2];
        [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
        
        // 中间的隔线 (* ￣3)(ε￣ *)
        UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(187.5, 20, 0.3, 25)];
        b.backgroundColor = [UIColor blackColor];
        [self.view addSubview:b];

    }
}

- (void)click1
{
    self.webView.x = 375;
    self.webView.y = 0;
    self.webView1.x = 0;
    self.webView1.y = 60;
    NSString *str = [NSString stringWithFormat:@"<html><head><title>Html加载</title></head><body>%@</body></html>", self.buyDetails];
    [self.webView1 loadHTMLString:str baseURL:nil];
}

- (void)click2
{
    self.webView.x = 0;
    self.webView.y = 40;
    self.webView1.x = 375;
    self.webView1.y = 0;
    NSString *str = [NSString stringWithFormat:@"<html><head><title>Html加载</title></head><body>%@</body></html>", self.shopDescription];
    [self.webView loadHTMLString:str baseURL:nil];
}

- (void)click3
{
    self.webView.x = 375;
    self.webView.y = 0;
    self.webView1.x = 0;
    self.webView1.y = 124;
    NSString *str = [NSString stringWithFormat:@"<html><head><title>Html加载</title></head><body>%@</body></html>", self.buyDetails];
    [self.webView1 loadHTMLString:str baseURL:nil];
}

- (void)click4
{
    self.webView.x = 0;
    self.webView.y = 60;
    self.webView1.x = 375;
    self.webView1.y = 0;
    NSString *str = [NSString stringWithFormat:@"<html><head><title>Html加载</title></head><body>%@</body></html>", self.shopDescription];
    [self.webView loadHTMLString:str baseURL:nil];
}

@end
