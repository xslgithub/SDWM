//
//  UIColor+ZBRandomColor.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/6.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "UIColor+ZBRandomColor.h"

@implementation UIColor (ZBRandomColor)
+(UIColor *)randomColor{
    static BOOL seed = NO;
    if (!seed) {
        seed = YES;
        srandom(time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];//alpha为1.0,颜色完全不透明
}
@end
