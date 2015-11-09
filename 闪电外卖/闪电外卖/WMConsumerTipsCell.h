//
//  WMConsumerTipsCell.h
//  闪电外卖
//
//  Created by 朱波 on 15/11/3.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMConsumerTipsCell;

@protocol WMConsumerTipsCellDelagate <NSObject>
- (void)addButton:(WMConsumerTipsCell *)addressCell didClickTel:(NSString *)phoneStr;

@end

@interface WMConsumerTipsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 消费提示 */
@property (nonatomic, strong)NSString *consumerTips;

@property (nonatomic, weak)id<WMConsumerTipsCellDelagate> delegate;
@end
