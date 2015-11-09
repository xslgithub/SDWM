//
//  WMHomeCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/27.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMHomeCell.h"
#import "WMShopFrame.h"
#import "WMDetail.h"
#import "UIImageView+WebCache.h"

@interface WMHomeCell()

// 整体
@property (nonatomic, weak)UIView *entiretyView;

// 商家图片（小）
@property (nonatomic, weak)UIImageView *tiny_imageView;

// 商家名称
@property (nonatomic, weak)UILabel *titleLabel;

// 描述
@property (nonatomic, weak)UILabel *describeLabel;

// 市场价格
@property (nonatomic, weak)UILabel *market_priceLabel;

// 售卖价格
@property (nonatomic, weak)UILabel *current_priceLabel;

// 用户评分
@property (nonatomic, weak)UILabel *scoreLabel;

@end

@implementation WMHomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Home";
    WMHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMHomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 整体view
        UIView *entiretyView = [[UIView alloc] init];
        [self.contentView addSubview:entiretyView];
        self.entiretyView = entiretyView;
        
        // 商家图片（小）
        UIImageView *tiny_imageView = [[UIImageView alloc] init];
        [entiretyView addSubview:tiny_imageView];
        self.tiny_imageView = tiny_imageView;
        
        // 商家名称
        UILabel *titleLabel = [[UILabel alloc] init];
        [entiretyView addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel = titleLabel;
        
        // 商家描述
        UILabel *describeLabel = [[UILabel alloc] init];
        [entiretyView addSubview:describeLabel];
        describeLabel.numberOfLines = 0;
        describeLabel.font = [UIFont systemFontOfSize:14];
        describeLabel.textColor = [UIColor grayColor];
        self.describeLabel = describeLabel;
        
        // 市场价格
        UILabel *market_priceLabel = [[UILabel alloc] init];
        [entiretyView addSubview:market_priceLabel];
        market_priceLabel.font = [UIFont systemFontOfSize:12];
        market_priceLabel.textColor = [UIColor grayColor];
        self.market_priceLabel = market_priceLabel;
        
        // 售卖价格
        UILabel *current_priceLabel = [[UILabel alloc] init];
        [entiretyView addSubview:current_priceLabel];
        current_priceLabel.font = [UIFont systemFontOfSize:14];
        current_priceLabel.textColor = [UIColor redColor];
        self.current_priceLabel = current_priceLabel;

        // 用户评分
        UILabel *scoreLabel = [[UILabel alloc] init];
        [entiretyView addSubview:scoreLabel];
        scoreLabel.font = [UIFont systemFontOfSize:12];
        scoreLabel.textColor = [UIColor orangeColor];
        self.scoreLabel = scoreLabel;
    }
    return self;
}

- (void)setShopFrame:(WMShopFrame *)shopFrame
{
    _shopFrame = shopFrame;
    WMDetail *detail = shopFrame.detail;
    
    // 整体
    self.entiretyView.frame = shopFrame.entiretyViewF;
    
    // 商家图片
    self.tiny_imageView.frame = shopFrame.tiny_imageViewF;
    [self.tiny_imageView sd_setImageWithURL:[NSURL URLWithString:detail.tiny_image] placeholderImage:[UIImage imageNamed:@"h1"]];
    
    // 名称
    self.titleLabel.frame = shopFrame.titleLabelF;
    self.titleLabel.text = detail.title;
    
    // 商家描述
    self.describeLabel.frame = shopFrame.describeLabelF;
    self.describeLabel.text = detail.describe;
    
    // 市场价格
    self.market_priceLabel.frame = shopFrame.market_priceLabelF;
    int market = detail.market_price / 100;
    //    self.market_priceLabel.text = [NSString stringWithFormat:@"%d", market];
    // 设置横线
    NSString *str = [NSString stringWithFormat:@"%d", market];
    NSMutableAttributedString *strA = [[NSMutableAttributedString alloc] initWithString:str];
    [strA setAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, strA.length)];
    self.market_priceLabel.attributedText = strA;

    // 售卖价格
    self.current_priceLabel.frame = shopFrame.current_priceLabelF;
    int current = detail.current_price / 100;
    self.current_priceLabel.text = [NSString stringWithFormat:@"￥%d", current];

    // 用户评分
    self.scoreLabel.frame = shopFrame.scoreLabelF;
    self.scoreLabel.text = [NSString stringWithFormat:@"%.2f分", detail.score];
    
}
@end
