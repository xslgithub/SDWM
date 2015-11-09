//
//  WMDealDetailViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/29.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMDealDetailViewController.h"
#import "WMHomeViewController.h"
#import "AFNetworking.h"
#import "UIView+Extension.h"
#import "WMDealDetail.h"
#import "WMDealDetailDeal.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "WMDealPriceCell.h"
#import "WMPriceFrame.h"
#import "WMDetail.h"
#import "WMAppointmentCell.h"
#import "WMAddress.h"
#import "WMShop.h"
#import "WMAddressFrame.h"
#import "WMAddressCell.h"
#import "MBProgressHUD+MJ.h"
#import "WMShopIdsCell.h"
#import "WMBuyDetailsController.h"
#import "WMBuyContentsCell.h"
#import "WMConsumerTipsCell.h"
#import "WMShoppingCartViewController.h"
#import "WMRecommendCell.h"

@interface WMDealDetailViewController () <WMAddressCellDelagate, UIAlertViewDelegate, WMConsumerTipsCellDelagate>
// 顶部图片
@property (nonatomic, weak) UIImageView *topView;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)NSMutableArray *shops;

@property (nonatomic, strong)WMPriceFrame *priceF;
@property (nonatomic, strong)WMAddressFrame *addressF;
@property (nonatomic, strong)WMDealDetailDeal *dd;
@property (nonatomic, strong)WMConsumerTipsCell *tips;

// 商店名称
@property (nonatomic, strong)NSString *shopN;
// 商店地址
@property (nonatomic, strong)NSString *address;
// 电话
@property (nonatomic, strong)NSString *phone;
// 购买详情
@property (nonatomic, strong)NSString *buyDetails;
// 商户环境
@property (nonatomic, strong)NSString *shopDescription;
// 套餐内容
@property (nonatomic, strong)NSString *buyContents;
// 消费提示
@property (nonatomic, strong)NSString *consumerTips;
// 购买(按钮)view
@property (nonatomic, strong)UIView *btnView;
@end

@implementation WMDealDetailViewController
- (NSMutableArray *)shops
{
    if (!_shops) {
        self.shops = [NSMutableArray array];
    }
    
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:46/255.0 green:134/255.0 blue:230/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setAlpha:0.0];
    self.title = self.shopName;
    
    // 去掉滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 发送网络请求
    [self requestDetail];
    [self addressRequest];
    
    // 设置内边距(让cell往下移动一段距离)
    self.tableView.contentInset = UIEdgeInsetsMake(160, 0, 0, 0);
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -180, 375, 180)];
    topView.image = [UIImage imageNamed:@"hh"];
    topView.userInteractionEnabled = YES;
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;
    
    // 添加购买按钮
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 添加购买按钮
    UIView *view = [self AddButtonView];
    view.y = window.height - view.height;
    [window addSubview:view];
    self.btnView = view;

    // topview底部的view
    [self bottomView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [MBProgressHUD showMessage:@"正在加载中..."];
    self.btnView.y = 667 - self.btnView.height;
}

- (void)viewDidAppear:(BOOL)animated
{
    [MBProgressHUD hideHUD];
    // 添加返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:backBtn];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn = backBtn;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.btnView.y = 667;
}

- (void)clickBack
{
    [self.backBtn removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

// topview底部的view
- (void)bottomView
{
    // 底部的view
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 375, 60)];
    bottomView.backgroundColor = [UIColor grayColor];
    bottomView.alpha = 0.7;
    // 名字
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, 25)];
    labelOne.text = self.shopName;
    labelOne.font = [UIFont systemFontOfSize:19];
    labelOne.textColor = [UIColor whiteColor];
    [bottomView addSubview:labelOne];
    // 已售
    UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(270, 5, 100, 25)];
    labelTwo.text = [NSString stringWithFormat:@"已售%d", (int)self.saleNum];
    labelTwo.font = [UIFont systemFontOfSize:14];
    labelTwo.textColor = [UIColor whiteColor];
    [bottomView addSubview:labelTwo];
    // 商家描述
    UILabel *labelThree = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 355, 35)];
    labelThree.text = self.describe;
    labelThree.font = [UIFont systemFontOfSize:13];
    labelThree.textColor = [UIColor whiteColor];
    labelThree.numberOfLines = 0;
    [bottomView addSubview:labelThree];
    [self.topView addSubview:bottomView];
}

- (void)requestDetail
{
    // 1.创建一个请求操作管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 声明一下：服务器返回的是JSON数据
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // responseObject的类型是NSDictionary或者NSArray
    
    // 2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"deal_id"] = self.deal_id;
    [mgr.requestSerializer setValue:@"521b2d93910e6156d3176d9711eb04ff" forHTTPHeaderField:@"apikey"];
    // 3.发送一个GET请求
    NSString *url = @"http://apis.baidu.com/baidunuomi/openapi/dealdetail";
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary *json) {
         // 请求成功的时候调用这个block
         // 把json数据转成模型数据
         WMDealDetail *d = [WMDealDetail objectWithKeyValues:json];
         self.dd = d.deal;
         self.buyDetails = self.dd.buy_details;
         self.shopDescription = self.dd.shop_description;
         self.buyContents = self.dd.buy_contents;
         self.consumerTips = self.dd.consumer_tips;
         [self.topView sd_setImageWithURL:[NSURL URLWithString:self.dd.image]];
         
//         NSLog(@"%@", json);
         // 刷新表格
         [self.tableView reloadData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // 请求失败的时候调用调用这个block
         NSLog(@"请求失败%@", error);

     }];
}

- (void)addressRequest
{
    // 1.创建一个请求操作管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 声明一下：服务器返回的是JSON数据
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // responseObject的类型是NSDictionary或者NSArray
    
    // 2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"shop_id"] = self.shopID;
    [mgr.requestSerializer setValue:@"521b2d93910e6156d3176d9711eb04ff" forHTTPHeaderField:@"apikey"];
    // 3.发送一个GET请求
    NSString *url = @"http://apis.baidu.com/baidunuomi/openapi/shopinfo";
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary *json) {
         // 请求成功的时候调用这个block
         // 把json数据转成模型数据
         WMAddress *address = [WMAddress objectWithKeyValues:json];
         WMShop *shop = address.shop;
         self.address = shop.address;
         self.shopN = shop.shop_name;
         self.phone = shop.phone;
         // 刷新表格
         [self.tableView reloadData];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         // 请求失败的时候调用调用这个block
         NSLog(@"请求失败%@", error);
     }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return 2;
            break;
            
        case 3:
            return 2;
            break;
            
        case 4:
            return 1;
            break;
            
        case 5:
            return 1;
            break;
            
        default:
            return 5;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        WMDealPriceCell *cell = [WMDealPriceCell cellWithTableView:tableView];
        // 改变了
        WMDetail *price = [[WMDetail alloc] init];
        price.current_price = self.currentPrice;
        price.market_price = self.marketPrice;
        self.priceF = [[WMPriceFrame alloc] init];
        self.priceF.detail = price;
        cell.priceFrame = self.priceF;
        return cell;
    } else if(indexPath.section == 0 && indexPath.row == 1) {
        WMAppointmentCell *cell = [WMAppointmentCell cellWithTableView:tableView];
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        static NSString *ID = @"xianqing";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor = [UIColor redColor];
            cell.textLabel.text = @"消费即送电影选座抵用卷（购买后5日内，累计验劵满1元可送，没人送1次）";
        }
        return cell;
    }  else if(indexPath.section == 2 && indexPath.row == 0) {
        WMAddressCell *cell = [WMAddressCell cellWithTableView:tableView];
        // 让控制器成为WMAddressCell的代理
        cell.delegate = self;
        if (self.address == nil && self.shopN == nil) {
            return cell;
        }
        self.addressF = [[WMAddressFrame alloc] init];
        WMShop *shop = [[WMShop alloc] init];
        shop.phone = self.phone;
        shop.address = self.address;
        shop.shop_name = self.shopN;
        self.addressF.shop = shop;
        cell.addressF = self.addressF;
        return cell;
    }  else if(indexPath.section == 2 && indexPath.row == 1) {
        WMShopIdsCell *cell = [WMShopIdsCell cellWithTableView:tableView];
        if (self.dd.shop_ids.count == 0) {
            return cell;
        } else {
            cell.shopId = [NSString stringWithFormat:@"全部%ld家分店", self.dd.shop_ids.count];
        }
        return cell;
    }else if(indexPath.section == 3 && indexPath.row == 0) {
        WMBuyContentsCell *cell = [WMBuyContentsCell cellWithTableView:tableView];
        if (self.buyContents) {
            cell.buyContents = self.buyContents;
        }
        return cell;
    }else if(indexPath.section == 3 && indexPath.row == 1) {
        static NSString *ID = @"consumePrompt";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        cell.textLabel.text = @"图文详情";
        cell.textLabel.textColor = [UIColor colorWithRed:253/255.0 green:137/255.0 blue:225/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        return cell;
    }else if(indexPath.section == 4 && indexPath.row == 0) {
        WMConsumerTipsCell *cell = [WMConsumerTipsCell cellWithTableView:tableView];
        if (self.consumerTips) {
            cell.consumerTips = self.dd.consumer_tips;
            cell.delegate = self;
        }
        return cell;
    }else if(indexPath.section == 5 && indexPath.row == 0) {
        WMRecommendCell *cell = [WMRecommendCell cellWithTableView:tableView];
        if (cell.data == nil) {
            cell.data = self.data;
        }
        return cell;
    }else {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        return cell;
    }
}

// 判断点击了哪行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3 && indexPath.row == 1) {
        WMBuyDetailsController *buy = [[WMBuyDetailsController alloc] init];
        [self.navigationController pushViewController:buy animated:YES];
        buy.buyDetails = self.buyDetails;
        buy.shopDescription = self.shopDescription;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navigationController.navigationBar.alpha = (self.tableView.contentOffset.y + 128) / 64;
    self.backBtn.alpha = -(self.tableView.contentOffset.y + 128) / 64;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return self.priceF.cellHeight;
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        return 40;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        return 55;
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        return self.addressF.cellHeight;
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        return 45;
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        return 155;
    } else if (indexPath.section == 3 && indexPath.row == 1) {
        return 45;
    } else if (indexPath.section == 4 && indexPath.row == 0) {
        return 210;
    } else if(indexPath.section == 5 && indexPath.row == 0) {
        return 800;
    }else {
        return 200;
    }
}

// 设置分组的样式
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

// 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

// 尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - WMAddressCellDelagate代理方法
- (void)addButton:(WMAddressCell *)addressCell didClickButton:(NSString *)phoneStr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.phone message:@"确定拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) { // 点击了确定
        NSLog(@"确定--电话是%@", self.phone);
    } else {
        NSLog(@"取消");
    }
}

#pragma mark -WMConsumerTipsCellDelagate代理方法
- (void)addButton:(WMConsumerTipsCell *)addressCell didClickTel:(NSString *)phoneStr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:phoneStr message:@"确定拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

// 创建购买按钮
- (UIView *)AddButtonView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 125, 44)];
    btn1.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyButton"]];
    imageView.width = 25;
    imageView.height = 25;
    imageView.x = (btn1.width - imageView.width) * 0.5;
    imageView.y = (btn1.height - imageView.height) * 0.5;
    [btn1 addSubview:imageView];
    [view addSubview:btn1];
    [btn1 addTarget:self action:@selector(shoppingCart) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(125, 0, 125, 44)];
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"加入购物车" forState:UIControlStateNormal];
    [view addSubview:btn2];
    [btn2 addTarget:self action:@selector(AddShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(250, 0, 125, 44)];
    btn3.backgroundColor = [UIColor colorWithRed:253/255.0 green:137/255.0 blue:225/255.0 alpha:1.0];
    [btn3 setTitle:@"立即抢购" forState:UIControlStateNormal];
    [view addSubview:btn3];
    [btn3 addTarget:self action:@selector(rob) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

- (void)shoppingCart
{
    WMShoppingCartViewController *sc = [[WMShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
}

- (void)AddShoppingCart
{
    NSLog(@"加入购物车");
}

- (void)rob
{
    NSLog(@"立即抢购");
}

@end
