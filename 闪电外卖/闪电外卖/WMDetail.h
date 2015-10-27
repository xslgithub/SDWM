//
//  WMDetail.h
//  闪电外卖
//
//  Created by 朱波 on 15/10/27.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMDetail : NSObject
// 商家图片（小）
@property (nonatomic, strong)NSString *tiny_image;

// 商家名称
@property (nonatomic, strong)NSString *title;

// 描述
@property (nonatomic, strong)NSString *describe;

// 市场价格
@property (nonatomic, assign)int market_price;

// 售卖价格
@property (nonatomic, assign)int current_price;

// 用户评分
@property (nonatomic, assign)float score;

@end
