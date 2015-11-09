//
//  WMAddressFrame.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/31.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMAddressFrame.h"
#import "NSString+Extension.h"
#import "WMAddress.h"
#import "WMShop.h"

@implementation WMAddressFrame

- (void)setShop:(WMShop *)shop
{
    _shop = shop;
    // 间距
    CGFloat padding = 10;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 商店名称
    CGFloat nameX = 15;
    CGFloat nameY = padding;
    CGFloat maxW = cellW - padding * 7;
    CGSize nameSize = [shop.shop_name sizeWithFont:[UIFont systemFontOfSize:15] maxW:maxW];
    self.shop_nameF = (CGRect){{nameX, nameY}, nameSize};
    
    // 商店地址
    CGFloat addressX = 15;
    CGFloat addressY = padding + padding * 2;
    CGFloat addressW = cellW - padding * 7;
    CGSize addressSize = [shop.address sizeWithFont:[UIFont systemFontOfSize:13] maxW:addressW];
    self.addressF = (CGRect){{addressX, addressY}, addressSize};
    
    // 电话
    CGFloat phoneX = 350;
    CGFloat phoneY = addressY;
    CGFloat phoneW = 15;
    CGFloat phoneH = 15;
    self.phoneF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    // 整体
    CGFloat entiretyX = 0;
    CGFloat entiretyY = 0;
    CGFloat entiretyW = cellW;
    CGFloat entiretyH = CGRectGetMaxY(self.addressF) + padding;
    self.entiretyViewF = CGRectMake(entiretyX, entiretyY, entiretyW, entiretyH);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.entiretyViewF) + padding * 0.2;
}

@end
