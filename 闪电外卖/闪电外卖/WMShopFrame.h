//
//  WMShopFrame.h
//  闪电外卖
//
//  Created by 朱波 on 15/10/27.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WMDetail;

@interface WMShopFrame : NSObject
@property (nonatomic, strong)WMDetail *detail;

// 整体
@property (nonatomic, assign)CGRect entiretyViewF;

// 商家图片（小）
@property (nonatomic, assign)CGRect tiny_imageViewF;

// 商家名称
@property (nonatomic, assign)CGRect titleLabelF;

// 描述
@property (nonatomic, assign)CGRect describeLabelF;

// 市场价格
@property (nonatomic, assign)CGRect market_priceLabelF;

// 售卖价格
@property (nonatomic, assign)CGRect current_priceLabelF;

// 用户评分
@property (nonatomic, assign)CGRect scoreLabelF;

// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
