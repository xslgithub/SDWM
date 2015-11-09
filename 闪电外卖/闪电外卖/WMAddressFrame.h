//
//  WMAddressFrame.h
//  闪电外卖
//
//  Created by 朱波 on 15/10/31.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WMShop;

@interface WMAddressFrame : NSObject
@property (nonatomic, strong)WMShop *shop;
// 整体
@property (nonatomic, assign)CGRect entiretyViewF;

// 商店名称
@property (nonatomic, assign)CGRect shop_nameF;

// 商店地址
@property (nonatomic, assign)CGRect addressF;

// 电话
@property (nonatomic, assign)CGRect phoneF;

// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
