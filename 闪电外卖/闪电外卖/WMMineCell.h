//
//  WMMineCell.h
//  闪电外卖
//
//  Created by 朱波 on 15/11/8.
//  Copyright © 2015年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMMineCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setCellImageName:(NSString *)imageName andName:(NSString *)name;
@end
