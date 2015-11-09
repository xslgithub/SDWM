//
//  WMDealPriceCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/31.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMDealPriceCell.h"
#import "WMPriceFrame.h"
#import "WMDetail.h"

@interface WMDealPriceCell()
// 整体
@property (nonatomic, weak)UIView *entiretyView;

// 市场价格
@property (nonatomic, weak)UILabel *market_priceLabel;

// 售卖价格
@property (nonatomic, weak)UILabel *current_priceLabel;

@end

@implementation WMDealPriceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"price";
    WMDealPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMDealPriceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 整体view
        UIView *entiretyView = [[UIView alloc] init];
        [self.contentView addSubview:entiretyView];
        self.entiretyView = entiretyView;
        
        // 市场价格
        UILabel *market_priceLabel = [[UILabel alloc] init];
        [entiretyView addSubview:market_priceLabel];
        market_priceLabel.font = [UIFont systemFontOfSize:14];
        market_priceLabel.textColor = [UIColor grayColor];
        self.market_priceLabel = market_priceLabel;
        
        // 售卖价格
        UILabel *current_priceLabel = [[UILabel alloc] init];
        [entiretyView addSubview:current_priceLabel];
        current_priceLabel.font = [UIFont systemFontOfSize:25];
        current_priceLabel.textColor = [UIColor redColor];
        self.current_priceLabel = current_priceLabel;
        
    }
    return self;
}

- (void)setPriceFrame:(WMPriceFrame *)priceFrame
{
    _priceFrame = priceFrame;
    WMDetail *detail = priceFrame.detail;
    
    // 整体
    self.entiretyView.frame = priceFrame.entiretyViewF;
    
    // 售卖价格
    self.current_priceLabel.frame = priceFrame.current_priceLabelF;
    int current = detail.current_price / 100;
    self.current_priceLabel.text = [NSString stringWithFormat:@"￥%d", current];
    
    // 市场价格
    self.market_priceLabel.frame = priceFrame.market_priceLabelF;
    int market = detail.market_price / 100;
    //    self.market_priceLabel.text = [NSString stringWithFormat:@"%d", market];
    // 设置横线
    NSString *str = [NSString stringWithFormat:@"%d", market];
    NSMutableAttributedString *strA = [[NSMutableAttributedString alloc] initWithString:str];
    [strA setAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, strA.length)];
    self.market_priceLabel.attributedText = strA;
    
    
}

@end
