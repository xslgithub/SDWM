//
//  WMLoginCell.h
//  闪电外卖
//
//  Created by 朱波 on 15/11/9.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMLoginCell;

@protocol WMLoginCellDelegate <NSObject>
- (void)clickButton:(WMLoginCell *)loginCell didClickButton:(NSString *)name;

@end

@interface WMLoginCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak)id<WMLoginCellDelegate> delegate;

@end
