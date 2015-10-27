//
//  WMData.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/27.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMData.h"
#import "MJExtension.h"
#import "WMDetail.h"

@implementation WMData
- (NSDictionary *)objectClassInArray
{
    return @{@"deals": [WMDetail class]};
}
@end
