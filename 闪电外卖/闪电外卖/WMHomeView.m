//
//  WMHomeView.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/26.
//  Copyright © 2015年 WM. All rights reserved.
//  设置首页header上按钮的属性

#import "WMHomeView.h"

@implementation WMHomeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 文字居中
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        // 设置图片显示模式
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

// 设置button文字的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *0.9;
    
    CGFloat titleW = contentRect.size.width;
    
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
    
}

// 设置button图片的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = CGRectGetWidth(contentRect);
    
    CGFloat imageH = contentRect.size.height * 0.7;
    
    return CGRectMake(0, 10, imageW, imageH);
    
}

@end
