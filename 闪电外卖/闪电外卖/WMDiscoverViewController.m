//
//  WMDiscoverViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/25.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMDiscoverViewController.h"
#import "WMText1ViewController.h"

@interface WMDiscoverViewController ()

@end

@implementation WMDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WMText1ViewController *text1 = [[WMText1ViewController alloc] init];
    [self.navigationController pushViewController:text1 animated:YES];
}

@end
