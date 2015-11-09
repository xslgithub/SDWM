//
//  WMLoginCell.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/9.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMLoginCell.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"

@interface WMLoginCell()<UITextFieldDelegate>

// 整体
@property (nonatomic, weak)UIView *entiretyView;

@property (nonatomic, strong)UIButton *accountBtn;

@property (nonatomic, strong)UITextField *accountNum;

@property (nonatomic, strong)UITextField *pwdNum;

@property (nonatomic, strong)UIButton *login;

@property (nonatomic, strong)UIButton *otherLogin;

@property (nonatomic, assign)BOOL otherClick;

@end

@implementation WMLoginCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"mine";
    WMLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WMLoginCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
        
        // 整体view
        UIView *entiretyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellW, 330)];
        [self.contentView addSubview:entiretyView];
        self.entiretyView = entiretyView;
        
        // 分隔线
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, cellW, 0.1)];
        label.backgroundColor = [UIColor blackColor];
        [entiretyView addSubview:label];
        
        // 账号
        UIView *account = [[UIView alloc] initWithFrame:CGRectMake(0, 20, entiretyView.width, 44)];
        account.backgroundColor = [UIColor whiteColor];
        [entiretyView addSubview:account];
        
        CGFloat accountImageW = 16;
        CGFloat accountImageH = 22;
        UIImageView *accountImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, (account.height - accountImageH) * 0.5, accountImageW, accountImageH)];
        accountImage.image = [UIImage imageNamed:@"icon_phone"];
        [account addSubview:accountImage];
        
        UITextField *accountNum = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountImage.frame) + 10, 0, 230, 44)];
        accountNum.font = [UIFont systemFontOfSize:13];
        accountNum.placeholder = @"请输入手机号";
        accountNum.clearButtonMode = UITextFieldViewModeWhileEditing;
        [account addSubview:accountNum];
        [accountNum addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.accountNum = accountNum;
        
        NSString *str = @"获取验证码";
        CGSize accountBtnSize = [str sizeWithFont:[UIFont systemFontOfSize:13]];
        UIButton *accountBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountNum.frame) +10, (accountNum.height - accountBtnSize.height) * 0.5, accountBtnSize.width, accountBtnSize.height)];
        accountBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [accountBtn setTitleColor:[UIColor colorWithRed:195/255.0 green:194/255.0 blue:201/255.0 alpha:1.0] forState:UIControlStateNormal];
        [accountBtn setTitle:str forState:UIControlStateNormal];
        accountBtn.enabled = NO;
        [accountBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [account addSubview:accountBtn];
        self.accountBtn = accountBtn;
        
        // 分隔线
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(account.frame), 375, 0.1)];
        label1.backgroundColor = [UIColor blackColor];
        [entiretyView addSubview:label1];
        
        // 密码
        UIView *pwd = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(account.frame), entiretyView.width, 44)];
        pwd.backgroundColor = [UIColor whiteColor];
        [entiretyView addSubview:pwd];
        
        CGFloat pwdW = 16;
        CGFloat pwdH = 22;
        UIImageView *pwdImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, (pwd.height - pwdH) * 0.5, pwdW, pwdH)];
        pwdImage.image = [UIImage imageNamed:@"icon_pin"];
        [pwd addSubview:pwdImage];
        
        UITextField *pwdNum = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pwdImage.frame) + 10, 0, 230, 44)];
        pwdNum.font = [UIFont systemFontOfSize:13];
        pwdNum.placeholder = @"请输入短信中的验证码";
        pwdNum.secureTextEntry = YES;
        [pwd addSubview:pwdNum];
        self.pwdNum = pwdNum;
        [pwdNum addTarget:self action:@selector(pwdTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        pwdNum.delegate = self;
        
        // 分隔线
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pwd.frame), 375, 0.1)];
        label2.backgroundColor = [UIColor blackColor];
        [entiretyView addSubview:label2];
        
        UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(pwd.frame) + 10, 345, 40)];
        [login setTitle:@"登录" forState:UIControlStateNormal];
        login.backgroundColor = [UIColor colorWithRed:215/255.0 green:214/255.0 blue:221/255.0 alpha:1.0];
        [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        login.titleLabel.font = [UIFont systemFontOfSize:16];
        [login.layer setCornerRadius:4];
        [entiretyView addSubview:login];
        self.login = login;
        login.enabled = NO;
        [login addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        // 分隔线
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(login.frame) + 30, 345, 0.4)];
        label3.backgroundColor = [UIColor blackColor];
        [entiretyView addSubview:label3];
        
        // 其他登录
        CGFloat otherLoginW = 80;
        UIButton *otherLogin = [[UIButton alloc] initWithFrame:CGRectMake((cellW - otherLoginW) * 0.5, CGRectGetMaxY(label3.frame) + 30, otherLoginW, 40)];
        [otherLogin setTitle:@"其它登录" forState:UIControlStateNormal];
        [otherLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [entiretyView addSubview:otherLogin];
        self.otherLogin = otherLogin;
        
        UIButton *weixin = [[UIButton alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(otherLogin.frame) + 20, 45, 45)];
        [weixin setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [entiretyView addSubview:weixin];
        [weixin addTarget:self action:@selector(clickWeixin) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *weibo = [[UIButton alloc] initWithFrame:CGRectMake(375 - 145, CGRectGetMaxY(otherLogin.frame) + 20, 45, 45)];
        [weibo setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
        [entiretyView addSubview:weibo];
        [weibo addTarget:self action:@selector(clickWeibo) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)clickWeixin
{
    NSLog(@"点击了微信");
}

- (void)clickWeibo
{
    if ([self.delegate respondsToSelector:@selector(clickButton:didClickButton:)]) {
        [self.delegate clickButton:self didClickButton:@"weibo"];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length >= 11) {
        if (self.pwdNum.text.length >= 6) {
            self.login.backgroundColor = [UIColor colorWithRed:253/255.0 green:137/255.0 blue:225/255.0 alpha:1.0];
            self.login.enabled = YES;
        }
        [self.accountBtn setTitleColor:[UIColor colorWithRed:253/255.0 green:137/255.0 blue:225/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.accountBtn.enabled = YES;
        
    } else {
        [self.accountBtn setTitleColor:[UIColor colorWithRed:195/255.0 green:194/255.0 blue:201/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.accountBtn.enabled = NO;
        
        self.login.backgroundColor = [UIColor colorWithRed:195/255.0 green:194/255.0 blue:201/255.0 alpha:1.0];
        self.login.enabled = NO;
    }
}

- (void)pwdTextFieldDidChange:(UITextField *)textField
{
    if (textField.text.length >= 6 && self.accountNum.text.length >= 11) {
        self.login.backgroundColor = [UIColor colorWithRed:253/255.0 green:137/255.0 blue:225/255.0 alpha:1.0];
        self.login.enabled = YES;
    } else {
        self.login.backgroundColor = [UIColor colorWithRed:195/255.0 green:194/255.0 blue:201/255.0 alpha:1.0];
        self.login.enabled = NO;
    }
}

- (void)click
{
    NSLog(@"click");
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.contentView.y = 0;
}

@end
