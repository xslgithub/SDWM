//
//  WMShopFrame.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/27.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMShopFrame.h"
#import "WMDetail.h"
#import "NSString+Extension.h"

@implementation WMShopFrame
- (void)setDetail:(WMDetail *)detail
{
    _detail = detail;
    // 间距
    CGFloat padding = 10;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 商家图片（小）
    CGFloat imageW = 115;
    CGFloat imageH = 70;
    CGFloat imageX = padding;
    CGFloat imageY = padding;
    self.tiny_imageViewF = CGRectMake(imageX, imageY, imageW, imageH);
    
    // 商家名称
    CGFloat titleX = CGRectGetMaxX(self.tiny_imageViewF) + padding;
    CGFloat titleY = imageY;
    CGSize nameSize = [detail.title sizeWithFont:[UIFont systemFontOfSize:15]];
    self.titleLabelF = (CGRect){{titleX, titleY}, nameSize};
    
    // 描述
    CGFloat describeX = CGRectGetMaxX(self.tiny_imageViewF) + padding;
    CGFloat describeY = CGRectGetMaxY(self.titleLabelF) + 5;
    CGFloat maxW = cellW - imageW - 30;
    CGSize describeSize = [detail.describe sizeWithFont:[UIFont systemFontOfSize:12] maxW:maxW];
    self.describeLabelF = (CGRect){{describeX, describeY}, describeSize};
    
    // 售卖价格
    CGFloat cpriceX = CGRectGetMaxX(self.tiny_imageViewF) + padding;
    CGSize cpriceSize = [[NSString stringWithFormat:@"%d", detail.current_price] sizeWithFont:[UIFont systemFontOfSize:12]];
    CGFloat cpriceY = CGRectGetMaxY(self.tiny_imageViewF) - cpriceSize.height;
    self.current_priceLabelF = (CGRect){{cpriceX, cpriceY}, cpriceSize};
    
    // 市场价格
    CGFloat mpriceX = CGRectGetMaxX(self.current_priceLabelF) + 5;
    CGSize mpriceSize = [[NSString stringWithFormat:@"%d", detail.market_price] sizeWithFont:[UIFont systemFontOfSize:10]];
    CGFloat mpriceY = CGRectGetMaxY(self.current_priceLabelF) - mpriceSize.height;
    self.market_priceLabelF = (CGRect){{mpriceX, mpriceY}, mpriceSize};

    // 用户评分
    CGFloat scoreX = cellW - 50;
    CGFloat scoreY = mpriceY;
    CGSize scoreSize = [[NSString stringWithFormat:@"%f分", detail.score] sizeWithFont:[UIFont systemFontOfSize:12]];
    self.scoreLabelF = (CGRect){{scoreX, scoreY}, scoreSize};

    // 整体
    CGFloat entiretyX = 0;
    CGFloat entiretyY = 1;
    CGFloat entiretyW = cellW;
    CGFloat entiretyH = CGRectGetMaxY(self.tiny_imageViewF) + padding;
    self.entiretyViewF = CGRectMake(entiretyX, entiretyY, entiretyW, entiretyH);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.entiretyViewF);
}
@end
