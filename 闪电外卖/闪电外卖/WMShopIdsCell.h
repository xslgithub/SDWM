//
//  WMShopIdsCell.h
//  闪电外卖
//
//  Created by 朱波 on 15/11/1.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMShopIdsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)NSString *shopId;
@end
