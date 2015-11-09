//
//  WMDealDetailDeal.h
//  闪电外卖
//
//  Created by 朱波 on 15/10/29.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMDealDetailDeal : NSObject

// 图片地址
@property (nonatomic, strong)NSString *image;

// 商户列表
@property (nonatomic, strong)NSArray *shop_ids;

// 消费提示
@property (nonatomic, strong)NSString *consumer_tips;

// 购买详情
@property (nonatomic, strong)NSString *buy_details;

// 商户环境
@property (nonatomic, strong)NSString *shop_description;

// 套餐内容
@property (nonatomic, strong)NSString *buy_contents;


@end
