//
//  WMListButton.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/8.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMListButton.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"

@implementation WMListButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        // 设置图片显示模式
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

// 设置button文字的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *0.2;
    
    CGFloat titleW = contentRect.size.width;
    
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
    
}

// 设置button图片的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 36;
    CGFloat imageH = 36;
    return CGRectMake((self.width - imageW) * 0.5, 5, imageW, imageH);
}


@end
