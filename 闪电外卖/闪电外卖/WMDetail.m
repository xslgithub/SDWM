//
//  WMDetail.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/27.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMDetail.h"
#import "WMShops.h"

@implementation WMDetail
- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"describe" : @"description"};
}

- (NSDictionary *)objectClassInArray
{
    return @{@"shops": [WMShops class]};
}
@end
