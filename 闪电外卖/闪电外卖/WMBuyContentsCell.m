//
//  WMBuyContentsCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/3.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMBuyContentsCell.h"

@interface WMBuyContentsCell()

// 整体
@property (nonatomic, weak)UIView *entiretyView;

@property (nonatomic, strong)UILabel *topLabel;

@property (nonatomic, strong)UIWebView *webView;
@end

@implementation WMBuyContentsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"buyContents";
    WMBuyContentsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMBuyContentsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setBuyContents:(NSString *)buyContents
{
    _buyContents = buyContents;
    // 整体view
    UIView *entiretyView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 375, 155)];
    [self.contentView addSubview:entiretyView];
    self.entiretyView = entiretyView;
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
    topLabel.text = @"套餐内容";
    [entiretyView addSubview:topLabel];
    self.topLabel = topLabel;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(topLabel.frame) + 5, 375, 100)];
    NSString *str = [NSString stringWithFormat:@"<html><head><title></title></head><body>%@</body></html>", self.buyContents];
    [webView loadHTMLString:str baseURL:nil];
    [entiretyView addSubview:webView];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    self.webView = webView;
    
}

@end
