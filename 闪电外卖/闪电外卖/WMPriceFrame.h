//
//  WMPriceFrame.h
//  闪电外卖
//
//  Created by 朱波 on 15/10/31.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
@class WMDetail;

@interface WMPriceFrame : NSObject
@property (nonatomic, strong)WMDetail *detail;
// 整体
@property (nonatomic, assign)CGRect entiretyViewF;

// 售卖价格
@property (nonatomic, assign)CGRect current_priceLabelF;

// 市场价格
@property (nonatomic, assign)CGRect market_priceLabelF;

// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
