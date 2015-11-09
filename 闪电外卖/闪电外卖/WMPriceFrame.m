//
//  WMPriceFrame.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/31.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMPriceFrame.h"
#import "NSString+Extension.h"
#import "WMDetail.h"

@implementation WMPriceFrame

- (void)setDetail:(WMDetail *)detail
{
    _detail = detail;
    // 间距
    CGFloat padding = 10;
    
    // 售卖价格
    CGFloat currentPriceX = padding;
    CGFloat currentPriceY = padding * 2;
    CGSize currentPriceSize = [[NSString stringWithFormat:@"%d", detail.current_price] sizeWithFont:[UIFont systemFontOfSize:25]];
    self.current_priceLabelF = (CGRect){{currentPriceX, currentPriceY}, currentPriceSize};
    
    // 市场价格
    CGFloat marketPriceLabelX = CGRectGetMaxX(self.current_priceLabelF) + 5;
    CGSize marketPriceLabelSize = [[NSString stringWithFormat:@"%d", detail.market_price] sizeWithFont:[UIFont systemFontOfSize:14]];
    CGFloat marketPriceLabelY = CGRectGetMaxY(self.current_priceLabelF) - marketPriceLabelSize.height - 3;
    self.market_priceLabelF = (CGRect){{marketPriceLabelX, marketPriceLabelY}, marketPriceLabelSize};
    
    // 整体
    CGFloat entiretyX = 0;
    CGFloat entiretyY = 1;
    CGFloat entiretyW = [UIScreen mainScreen].bounds.size.width;
    CGFloat entiretyH = CGRectGetMaxY(self.market_priceLabelF) + padding * 2;
    self.entiretyViewF = CGRectMake(entiretyX, entiretyY, entiretyW, entiretyH);

    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.entiretyViewF);

}
@end
