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


@interface WMHomeViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@end

@implementation WMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *iconName = @[@"美食",
                        @"超市",
                        @"鲜果购",
                        @"甜点饮品",
                        @"土豪馆",
                        @"SD专送",
                        @"鲜花蛋糕",
                        @"送药上门"
                        ];
    
    // 设置scrollView
    [self setScrollView];
    
    // 设置listView
    
    CGFloat btnW = 94;
    CGFloat btnH = 81;
    
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
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
    }
}

- (void)click
{
    NSLog(@"nihao");
}

#pragma mark - TableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"bobo我爱你";
    return cell;
}


#pragma mark - ScrollView
- (void)setScrollView
{
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"],
                        [UIImage imageNamed:@"h4.jpg"]
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
