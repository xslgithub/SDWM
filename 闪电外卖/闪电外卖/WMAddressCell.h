//
//  WMAddressCell.h
//  闪电外卖
//
//  Created by 朱波 on 15/10/31.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMAddressFrame, WMAddressCell;

@protocol WMAddressCellDelagate <NSObject>
- (void)addButton:(WMAddressCell *)addressCell didClickButton:(NSString *)phoneStr;

@end

@interface WMAddressCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)WMAddressFrame *addressF;

@property (nonatomic, weak)id<WMAddressCellDelagate> delegate;
@end
