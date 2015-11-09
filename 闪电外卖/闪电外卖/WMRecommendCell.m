//
//  WMRecommendCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/6.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMRecommendCell.h"
#import "WMData.h"
#import "WMDetail.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"



@interface WMRecommendCell()
// 整体
@property (nonatomic, weak)UIView *entiretyView;

@property (nonatomic, strong)UIView *view;

@property (nonatomic, strong)UILabel *titleLabel;
@end

@implementation WMRecommendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"recommend";
    WMRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMRecommendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setData:(WMData *)data
{
    _data = data;
    NSArray *array = data.deals;
    
    // 整体view
    UIView *entiretyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 800)];
    [self.contentView addSubview:entiretyView];
    self.entiretyView = entiretyView;
    
    // 为您推荐
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    [entiretyView addSubview:titleLabel];
    titleLabel.text = @"为您推荐";
    titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel = titleLabel;
    
    // 商家图片（小）
    CGFloat shopW = 165;
    CGFloat shopH = 165;
    CGFloat pading = 15;
    for (int i = 0; i < 8; i++) {
        int row = i / 2;
        int col = i % 2;
        CGFloat shopX = col * shopW + pading * (i % 2);
        CGFloat shopY = row * shopH + pading * (i / 2);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(shopX + pading, shopY + CGRectGetMaxY(self.titleLabel.frame) + pading, shopW, shopH)];
        // 随机颜色
        [entiretyView addSubview:view];
        self.view = view;
        
        // 随机店铺
        NSInteger random = arc4random() % array.count;
        WMDetail *detail = array[random];
    
        // 设置图片
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 165, 110)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:detail.tiny_image] placeholderImage:[UIImage imageNamed:@"hh"]];
        [view addSubview:imageV];
        
        // 设置名称
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), 130, 25)];
        title.text = detail.title;
        title.font = [UIFont systemFontOfSize:15];
        [view addSubview:title];
        
        // ￥
        UILabel *rmb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame), 30, 40)];
        rmb.text = @"￥";
        rmb.textColor = [UIColor redColor];
        rmb.font = [UIFont systemFontOfSize:15];
        [view addSubview:rmb];
        
        // 售卖价格
        UILabel *current_priceLabel = [[UILabel alloc] init];
        CGFloat currentX = 15;
        CGFloat currentY = CGRectGetMaxY(title.frame) + 4;
        int current = detail.current_price / 100;
        current_priceLabel.text = [NSString stringWithFormat:@"%d", current];
        current_priceLabel.textColor = [UIColor redColor];
        current_priceLabel.font = [UIFont systemFontOfSize:22];
        CGSize currentSize = [[NSString stringWithFormat:@"%d", current] sizeWithFont:[UIFont systemFontOfSize:22]];
        current_priceLabel.frame = (CGRect){{currentX, currentY}, currentSize};
        
//        current_priceLabel.text = [NSString stringWithFormat:@"%d", current];
//        current_priceLabel.font = [UIFont systemFontOfSize:25];
//        current_priceLabel.textColor = [UIColor redColor];
        [view addSubview:current_priceLabel];
        
        // 市场价格
        UILabel *market_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(current_priceLabel.frame) + 5, CGRectGetMaxY(title.frame), 70, 40)];
        int market = detail.market_price / 100;
        market_priceLabel.text = [NSString stringWithFormat:@"%d", market];
        market_priceLabel.font = [UIFont systemFontOfSize:13];
        market_priceLabel.textColor = [UIColor grayColor];
        [view addSubview:market_priceLabel];
        
        NSString *str = [NSString stringWithFormat:@"%d", market];
        NSMutableAttributedString *strA = [[NSMutableAttributedString alloc] initWithString:str];
        [strA setAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, strA.length)];
        market_priceLabel.attributedText = strA;


    }
}

@end
