//
//  WMMineTableViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/25.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMMineTableViewController.h"
#import "UIView+Extension.h"
#import "WMListButton.h"
#import "WMMineCell.h"
#import "WMLoginViewController.h"
#import "UIImageView+WebCache.h"

@interface WMMineTableViewController ()
@property (nonatomic, strong)UIView *headerView;

@property (nonatomic, strong)UIButton *logBtn;

@property (nonatomic, strong)UIButton *registerBtn;
@end

@implementation WMMineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // 设置headerView内容
    [self setupHeaderView];
    // 取数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *iconStr = [defaults objectForKey:@"icon"];
    NSString *nameStr = [defaults objectForKey:@"name"];
    if (iconStr != nil) {
 
        self.logBtn.x = 400;
        self.registerBtn.x = 400;
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 55, 55)];
        [iconImage sd_setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:nil];
        [self.headerView addSubview:iconImage];
        [iconImage.layer setCornerRadius:4];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame) + 10, 28, 100, 30)];
        name.text = nameStr;
        name.textColor = [UIColor orangeColor];
        name.font = [UIFont systemFontOfSize:14];
        [self.headerView addSubview:name];
        
        // 退出
        UIButton *tuichu = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 100, iconImage.y + 18, 70, 25)];
        tuichu.backgroundColor = [UIColor redColor];
        tuichu.titleLabel.font = [UIFont systemFontOfSize:13];
        [tuichu setTitle:@"退出" forState:UIControlStateNormal];
        [tuichu.layer setCornerRadius:4];
        [self.headerView addSubview:tuichu];
        [tuichu addTarget:self action:@selector(tuichuClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)tuichuClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) { // 点击了确定
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        [defaults removeObjectForKey:@"icon"];
        [defaults removeObjectForKey:@"name"];
        
        [defaults synchronize];
        
        [self viewWillAppear:YES];
    } else {
        NSLog(@"取消");
    }
}

// 设置headerView内容
- (void)setupHeaderView
{
    // headerView
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 375, 150)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    // 登录按钮
    CGFloat logBtnW = 100;
    CGFloat logBtnH = 30;
    CGFloat logBtnX = (headerView.width - logBtnW) * 0.5;
    CGFloat logBtnY = 20;
    UIButton *logBtn = [[UIButton alloc] initWithFrame:CGRectMake(logBtnX, logBtnY, logBtnW, logBtnH)];
    [logBtn.layer setCornerRadius:4];
    [logBtn setTitle:@"登录" forState:UIControlStateNormal];
    logBtn.backgroundColor = [UIColor colorWithRed:253/255.0 green:137/255.0 blue:225/255.0 alpha:1.0];
    [headerView addSubview:logBtn];
    self.logBtn = logBtn;
    [logBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 注册
    CGFloat registerBtnW = 100;
    CGFloat registerBtnH = 20;
    CGFloat registerBtnX = (headerView.width - registerBtnW) * 0.5;
    CGFloat registerBtnY = CGRectGetMaxY(logBtn.frame) + 10;
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(registerBtnX, registerBtnY, registerBtnW, registerBtnH)];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithRed:253/255.0 green:137/255.0 blue:225/255.0 alpha:1.0] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:registerBtn];
    self.registerBtn = registerBtn;
    
    // 分隔线
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(registerBtn.frame) + 5, 375, 0.1)];
    label.backgroundColor = [UIColor blackColor];
    [headerView addSubview:label];
    
    // 菜单
    UIView *listView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), 375, 80)];
    [headerView addSubview:listView];
    
    // 糯米卷
    UIButton *nmj = [self btnName:@"糯米卷" andImageName:@"mine_nmj"];
    nmj.frame = CGRectMake(0, 0, 375 / 4, 80);
    [listView addSubview:nmj];
    [nmj addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 代付款
    UIButton *dfk = [self btnName:@"收藏" andImageName:@"mine_dfk"];
    dfk.frame = CGRectMake(CGRectGetMaxX(nmj.frame) + 1, 0, 375 / 4, 80);
    [listView addSubview:dfk];
    
    // 卡包
    UIButton *kb = [self btnName:@"卡包" andImageName:@"mine_kb"];
    kb.frame = CGRectMake(CGRectGetMaxX(dfk.frame) + 1, 0, 375 / 4, 80);
    [listView addSubview:kb];
    
    // 收藏
    UIButton *sc = [self btnName:@"收藏" andImageName:@"mine_sc"];
    sc.frame = CGRectMake(CGRectGetMaxX(kb.frame) + 1, 0, 375 / 4, 80);
    [listView addSubview:sc];

}

// 设置按钮
- (UIButton *)btnName:(NSString *)name andImageName:(NSString *)imageName
{
    WMListButton *btn = [[WMListButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor colorWithRed:83/255.0 green:83/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return btn;
}

// 监听
- (void)btnClick
{
    NSLog(@"糯米卷");
}

// 点击登录
- (void)loginClick
{
    WMLoginViewController *login = [[WMLoginViewController alloc] init];
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMMineCell *cell = [WMMineCell cellWithTableView:tableView];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell setCellImageName:@"mine_dd" andName:@"订单"];
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        [cell setCellImageName:@"mine_vip" andName:@"VIP会员"];
        return cell;
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        [cell setCellImageName:@"mine_jf" andName:@"积分"];
        return cell;
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        [cell setCellImageName:@"mine_ye" andName:@"余额"];
        return cell;
    }else if (indexPath.section == 2 && indexPath.row == 2) {
        [cell setCellImageName:@"mine_cxj" andName:@"促销卷"];
        return cell;
    }else if (indexPath.section == 2 && indexPath.row == 3) {
        [cell setCellImageName:@"mine_dyj" andName:@"抵用卷"];
        return cell;
    }else if (indexPath.section == 3 && indexPath.row == 0) {
        [cell setCellImageName:@"mine_sz" andName:@"设置"];
        return cell;
    } else {
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return 4;
            break;
            
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    return 3;
}

// 设置分组的样式
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

// 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

// 尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
