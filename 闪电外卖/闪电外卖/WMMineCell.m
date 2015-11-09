//
//  WMMineCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/8.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMMineCell.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"

@interface WMMineCell()
// 整体
@property (nonatomic, weak)UIView *entiretyView;

@end

@implementation WMMineCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"mine";
    WMMineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMMineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setCellImageName:(NSString *)imageName andName:(NSString *)name
{
    // 整体view
    UIView *entiretyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    [self.contentView addSubview:entiretyView];
    self.entiretyView = entiretyView;
    
    CGFloat iconImageW = 20;
    CGFloat iconImageH = 20;
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(15 ,(entiretyView.height - iconImageH) * 0.5 , iconImageW, iconImageH)];
    iconImage.image = [UIImage imageNamed:imageName];
    [entiretyView addSubview:iconImage];
    
    UILabel *label = [[UILabel alloc] init];
    CGSize labelSize = [name sizeWithFont:[UIFont systemFontOfSize:13]];
    CGFloat labelX = CGRectGetMaxX(iconImage.frame) + 10;
    CGFloat labelY = (entiretyView.height - labelSize.height) * 0.5;
    label.frame = CGRectMake(labelX, labelY, 200, labelSize.height);
    label.text = name;
    label.font = [UIFont systemFontOfSize:15];
    [entiretyView addSubview:label];
    
    CGFloat leftIconH = 10;
    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.width + 35, (entiretyView.height - leftIconH) * 0.5, 6, leftIconH)];
    leftIcon.image = [UIImage imageNamed:@"rightBtn"];
    [entiretyView addSubview:leftIcon];
    
    
}
@end
