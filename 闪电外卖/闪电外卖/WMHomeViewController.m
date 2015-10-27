//
//  WMHomeViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/25.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "SDCycleScrollView.h"
#import "WMHomeViewController.h"
#import "WMHomeView.h"
#import "WMHomeCell.h"

@interface WMHomeViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@end

@implementation WMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置scrollView
    [self setScrollView];
    
    // 设置listView
    [self setListView];
}

#pragma mark - TableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMHomeCell *cell = [WMHomeCell cellWithTableView:tableView];
    cell.textLabel.text = @"bozai我爱你";
    return cell;
}

#pragma mark -ListView
- (void)setListView
{
    NSArray *iconName = @[@"美食",
                          @"超市",
                          @"鲜果购",
                          @"甜点饮品",
                          @"土豪馆",
                          @"SD专送",
                          @"鲜花蛋糕",
                          @"送药上门"
                          ];
    // 按钮的宽高
    CGFloat btnW = 94;
    CGFloat btnH = 81;
    // 添加8个按钮
    for (int i = 0; i < 8; i++) {
        int row = i / 4;
        int col = i % 4;
        CGFloat btnX = col * btnW;
        CGFloat btnY = row * btnH;
        WMHomeView *btn = [[WMHomeView alloc] init];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon%d", i]] forState:UIControlStateNormal];
        
        [btn setTitle:iconName[i] forState:UIControlStateNormal];
        [self.listView addSubview:btn];
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
    }
}

// 监听按钮的点击
- (void)btnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            NSLog(@"点击了0");
            break;
            
        case 1:
            NSLog(@"点击了1");
            break;
            
        case 2:
            NSLog(@"点击了2");
            break;
            
        case 3:
            NSLog(@"点击了3");
            break;
            
        case 4:
            NSLog(@"点击了4");
            break;
            
        case 5:
            NSLog(@"点击了5");
            break;
            
        case 6:
            NSLog(@"点击了6");
            break;
            
        case 7:
            NSLog(@"点击了7");
            break;
            
        case 8:
            NSLog(@"点击了8");
            break;
    }
}

#pragma mark - ScrollView
- (void)setScrollView
{
    NSArray *images = @[[UIImage imageNamed:@"h0"],
                        [UIImage imageNamed:@"h1"],
                        [UIImage imageNamed:@"h2"],
                        [UIImage imageNamed:@"h3"],
                        [UIImage imageNamed:@"h4"]
                        ];
    
//    NSArray *titles = @[@"闪电外卖",
//                        @"全球最快",
//                        @"朱波龙哥",
//                        @"一统江湖"
//                        ];
    
    CGFloat w = self.view.bounds.size.width;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 130) imagesGroup:images];
    
//    cycleScrollView.titlesGroup = titles;
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.headView addSubview:cycleScrollView];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}

@end
