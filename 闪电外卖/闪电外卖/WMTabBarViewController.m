//
//  WMTabBarViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/25.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMTabBarViewController.h"
#import "WMHomeViewController.h"
#import "WMOrderViewController.h"
#import "WMDiscoverViewController.h"
#import "WMMineTableViewController.h"
#import "WMNavigationViewController.h"

@interface WMTabBarViewController ()

@end

@implementation WMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 外卖
    WMHomeViewController *home = [[WMHomeViewController alloc] init];
    [self addChildVc:home title:@"外卖" image:@"tabbar_waimai" selectedImage:@"tabbar_waimai_selected"];
    
    // 订单
    WMOrderViewController *order = [[WMOrderViewController alloc] init];
    [self addChildVc:order title:@"订单" image:@"tabbar_order" selectedImage:@"tabbar_order_selected"];
    
    // 发现
    WMDiscoverViewController *discover = [[WMDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    // 我的
    WMMineTableViewController *mine = [[WMMineTableViewController alloc] init];
    [self addChildVc:mine title:@"我的" image:@"tabbar_mine" selectedImage:@"tabbar_mine_selected"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置标题
    childVc.title = title;
    // 设置图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:46/255.0 green:134/255.0 blue:230/255.0 alpha:1.0];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 给外面传进来的控制器包装一个导航控制器
    WMNavigationViewController *nav = [[WMNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
@end
