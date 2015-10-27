//
//  WMHomeViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/25.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "SDCycleScrollView.h"
#import "WMHomeViewController.h"
#import "MJExtension.h"
#import "WMHomeView.h"
#import "WMHomeCell.h"
#import "WMShopFrame.h"
#import "AFNetworking.h"
#import "WMShopData.h"
#import "WMData.h"
#import "WMDetail.h"
#import "UIImageView+WebCache.h"

@interface WMHomeViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *shops;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@end

@implementation WMHomeViewController
- (NSMutableArray *)shops
{
    if (!_shops) {
        self.shops = [NSMutableArray array];
    }
    
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 去掉滚动条
    self.tableView.showsVerticalScrollIndicator = NO;

    // 设置scrollView
    [self setScrollView];
    
    // 设置listView
    [self setListView];
    
    // 发送网络请求
    [self requestShopData];
    
    
}

// 发送网络请求商户
- (void)requestShopData
{
    // 1.创建一个请求操作管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 声明一下：服务器返回的是JSON数据
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // responseObject的类型是NSDictionary或者NSArray
    
    // 2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"location"] = @"113988402, 22.542666";
    params[@"city_id"] = @300210000;
    //    params[@"radius"] = @1000;
    [mgr.requestSerializer setValue:@"521b2d93910e6156d3176d9711eb04ff" forHTTPHeaderField:@"apikey"];
    // 3.发送一个GET请求
    NSString *url = @"http://apis.baidu.com/baidunuomi/openapi/searchdeals";
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary *json) {
         // 请求成功的时候调用这个block
         // 把json数据转成模型数据
         WMShopData *shopData = [WMShopData objectWithKeyValues:json];
         WMData *data = shopData.data;
         
         NSArray *newFrames = [self stausFramesWithShops:data];
         
         [self.shops addObjectsFromArray:newFrames];
         
         // 刷新表格
         [self.tableView reloadData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // 请求失败的时候调用调用这个block
         NSLog(@"请求失败%@", error);
     }];
}

- (NSArray *)stausFramesWithShops:(WMData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    for (WMDetail *detail in data.deals) {
        WMShopFrame *f = [[WMShopFrame alloc] init];
        f.detail = detail;
        [array addObject:f];
    }
    return array;
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

#pragma mark - TableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMHomeCell *cell = [WMHomeCell cellWithTableView:tableView];
    cell.shopFrame = self.shops[indexPath.row];
    return cell;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WMShopFrame *shopF = self.shops[indexPath.row];
//    return shopF.cellHeight;
    return 90;
}


@end
