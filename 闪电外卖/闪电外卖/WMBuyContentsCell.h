//
//  WMBuyContentsCell.h
//  闪电外卖
//
//  Created by 朱波 on 15/11/3.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMBuyContentsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)NSString *buyContents;
@end
