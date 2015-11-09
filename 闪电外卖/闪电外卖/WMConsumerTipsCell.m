//
//  WMConsumerTipsCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/3.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMConsumerTipsCell.h"
#import "UIView+Extension.h"
#import "WMDealDetailViewController.h"

@interface WMConsumerTipsCell()<UIWebViewDelegate>
// 整体
@property (nonatomic, weak)UIView *entiretyView;

@property (nonatomic, strong)UILabel *topLabel;

@property (nonatomic, strong)UIWebView *webView;
@end

@implementation WMConsumerTipsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"consumerTips";
    WMConsumerTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMConsumerTipsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setConsumerTips:(NSString *)consumerTips
{
    _consumerTips = consumerTips;
    
    // 整体view
    UIView *entiretyView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 375, 200)];
    [self.contentView addSubview:entiretyView];
    self.entiretyView = entiretyView;
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
    topLabel.text = @"消费提示";
    [entiretyView addSubview:topLabel];
    self.topLabel = topLabel;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(-30, CGRectGetMaxY(topLabel.frame) + 5, 375, 150)];
    NSString *str = [NSString stringWithFormat:@"<html><head><title></title></head><body><table>%@</table></body></html>", self.consumerTips];
    webView.delegate = self;
    
    [webView loadHTMLString:str baseURL:nil];
    [entiretyView addSubview:webView];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    self.webView = webView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) { // 判断用户是否点击
        if ([self.delegate respondsToSelector:@selector(addButton:didClickTel:)]) {
            [self.delegate addButton:self didClickTel:[[request URL] absoluteString]];
        }
    }
    return YES;
}
@end
