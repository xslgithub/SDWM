//
//  WMShopIdsCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/1.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMShopIdsCell.h"

@interface WMShopIdsCell()
// 整体
@property (nonatomic, weak)UIView *entiretyView;
@property (nonatomic, strong)UIImageView *rigthView;
@property (nonatomic, strong)UILabel *shopIdNumLabel;

@end

@implementation WMShopIdsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"shopIds";
    WMShopIdsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMShopIdsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setShopId:(NSString *)shopId
{
    _shopId = shopId;
    // 整体view
    UIView *entiretyView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 375, 45)];
    [self.contentView addSubview:entiretyView];
    self.entiretyView = entiretyView;
    
    
    UILabel *shopIdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 20)];
    [entiretyView addSubview:shopIdNumLabel];
    shopIdNumLabel.text = self.shopId;
    shopIdNumLabel.textColor = [UIColor colorWithRed:253/255.0 green:137/255.0 blue:225/255.0 alpha:1.0];
    shopIdNumLabel.font = [UIFont systemFontOfSize:14];
    self.shopIdNumLabel = shopIdNumLabel;
    
    UIImageView *rigthView = [[UIImageView alloc] initWithFrame:CGRectMake(350, 17, 6, 10)];
    rigthView.image = [UIImage imageNamed:@"rightBtn"];
    [entiretyView addSubview:rigthView];
    self.rigthView = rigthView;
}

@end
