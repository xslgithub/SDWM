//
//  WMText1ViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/25.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMText1ViewController.h"
#import "WMText2ViewController.h"

@interface WMText1ViewController ()

@end

@implementation WMText1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WMText2ViewController *text2 = [[WMText2ViewController alloc] init];
    [self.navigationController pushViewController:text2 animated:YES];
}

@end
