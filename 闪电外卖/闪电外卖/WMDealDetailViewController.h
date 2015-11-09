//
//  WMDealDetailViewController.h
//  闪电外卖
//
//  Created by 朱波 on 15/10/29.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMData;

@interface WMDealDetailViewController : UITableViewController
// 商店ID
@property (nonatomic, assign)NSNumber *shopID;
// 城市ID
@property (nonatomic, assign)long cityID;
// 团单详情
@property (nonatomic, strong)NSNumber *deal_id;
// 商店名
@property (nonatomic, strong)NSString *shopName;
// 描述
@property (nonatomic, strong)NSString *describe;
// 已售
@property (nonatomic, strong)NSNumber *saleNum;

// 市场价格
@property (nonatomic, assign)int marketPrice;

// 售卖价格
@property (nonatomic, assign)int currentPrice;

@property (nonatomic, strong)WMData *data;
@end
