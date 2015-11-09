//
//  WMRecommendCell.h
//  闪电外卖
//
//  Created by 朱波 on 15/11/6.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMData;

@interface WMRecommendCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)WMData *data;
@end
