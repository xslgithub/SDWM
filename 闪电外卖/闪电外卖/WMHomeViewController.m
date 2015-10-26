//
//  WMHomeViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/25.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "SDCycleScrollView.h"
#import "WMHomeViewController.h"


@interface WMHomeViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headView;
@end

@implementation WMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"],
                        [UIImage imageNamed:@"h4.jpg"]
                        ];
    
    NSArray *titles = @[@"闪电外卖",
                        @"全球最快",
                        @"朱波龙哥",
                        @"一统江湖"
                        ];
    
    CGFloat w = self.view.bounds.size.width;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) imagesGroup:images];
    
    cycleScrollView.titlesGroup = titles;
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.headView addSubview:cycleScrollView];

    
    
}
#pragma mark - TableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


#pragma mark - ScrollView

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}
@end
