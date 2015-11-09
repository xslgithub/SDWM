//
//  WMAddressCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/31.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMAddressCell.h"
#import "WMAddress.h"
#import "WMShop.h"
#import "WMAddressFrame.h"

@interface WMAddressCell()
// 整体
@property (nonatomic, weak)UIView *entiretyView;
// 商店地址
@property (nonatomic, strong)UILabel *addressLabel;
// 商店名字
@property (nonatomic, strong)UILabel *nameLabel;
// 电话
@property (nonatomic, strong)UIButton *phoneButton;

@property (nonatomic, strong)WMShop *shop;
@end

@implementation WMAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"address";
    WMAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        
        // 商家名称
        UILabel *nameLabel = [[UILabel alloc] init];
        [entiretyView addSubview:nameLabel];
        nameLabel.font = [UIFont systemFontOfSize:15];
        self.nameLabel = nameLabel;
        
        // 商家地址
        UILabel *addressLabel = [[UILabel alloc] init];
        [entiretyView addSubview:addressLabel];
        addressLabel.numberOfLines = 0;
        addressLabel.font = [UIFont systemFontOfSize:13];
        addressLabel.textColor = [UIColor grayColor];
        self.addressLabel = addressLabel;
        
        // 电话
        UIButton *phoneButton = [[UIButton alloc] init];
        [entiretyView addSubview:phoneButton];
        self.phoneButton = phoneButton;
        [phoneButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        }
    return self;
}

- (void)click
{
    if ([self.delegate respondsToSelector:@selector(addButton:didClickButton:)]) {
        [self.delegate addButton:self didClickButton:self.shop.phone];
    }
}

- (void)setAddressF:(WMAddressFrame *)addressF
{
    _addressF = addressF;
    self.shop = addressF.shop;

    // 整体
    self.entiretyView.frame = addressF.entiretyViewF;
    
    // 名称
    self.nameLabel.frame = addressF.shop_nameF;
    self.nameLabel.text = self.shop.shop_name;
    
    // 商家地址
    self.addressLabel.frame = addressF.addressF;
    self.addressLabel.text = self.shop.address;
    
    // 电话
    self.phoneButton.frame = addressF.phoneF;
    [self.phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
}

@end
