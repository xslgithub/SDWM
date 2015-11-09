//
//  WMAppointmentCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/31.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMAppointmentCell.h"

@interface WMAppointmentCell()
// 整体
@property (nonatomic, weak)UIView *entiretyView;
@property (nonatomic, strong)UIImageView *oneView;

@property (nonatomic, strong)UIImageView *twoView;
@property (nonatomic, strong)UILabel *oneLabel;
@property (nonatomic, strong)UILabel *twoLabel;

@end

@implementation WMAppointmentCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"appointment";
    WMAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMAppointmentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        
        
        UIImageView *oneView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 15)];
        oneView.image = [UIImage imageNamed:@"sbt"];
        [entiretyView addSubview:oneView];
        self.oneView = oneView;
        
        UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(oneView.frame) + 3, oneView.frame.origin.y - 2, 50, 20)];
        [entiretyView addSubview:oneLabel];
        oneLabel.text = @"随便退";
        oneLabel.textColor = [UIColor grayColor];
        oneLabel.font = [UIFont systemFontOfSize:14];
        self.oneLabel = oneLabel;
        
        UIImageView *twoView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(oneLabel.frame), oneView.frame.origin.y, 15, 15)];
        twoView.image = [UIImage imageNamed:@"mfy"];
        [entiretyView addSubview:twoView];
        self.twoView = twoView;
        
        UILabel *twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(twoView.frame), oneLabel.frame.origin.y, 50, 20)];
        [entiretyView addSubview:twoLabel];
        twoLabel.text = @"免费约";
        twoLabel.textColor = [UIColor grayColor];
        twoLabel.font = [UIFont systemFontOfSize:14];
        self.oneLabel = twoLabel;
    }
    return self;
}

@end
