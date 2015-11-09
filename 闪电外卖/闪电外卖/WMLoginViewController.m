//
//  WMLoginViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/11/9.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMLoginViewController.h"
#import "WMLoginCell.h"
#import "UMSocial.h"
#import "WMMineTableViewController.h"

@interface WMLoginViewController ()<WMLoginCellDelegate>

@end

@implementation WMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去除滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 去除cell的分隔线
    self.tableView.separatorStyle = NO;
    
    self.title = @"登录";
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:243/255.0 alpha:1.0];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnClikc)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnClikc)];
}

- (void)leftBtnClikc
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMLoginCell *cell = [WMLoginCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:243/255.0 alpha:1.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 330;
}

#pragma mark - WMLoginCellDelegate
- (void)clickButton:(WMLoginCell *)loginCell didClickButton:(NSString *)name
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            // 存储数据
            // 1.利用NSUserDefaults,就能直接访问软件的偏好设置(Library/Preferences)
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            // 2.存储数据
            [defaults setObject:snsAccount.iconURL forKey:@"icon"];
            [defaults setObject:snsAccount.userName forKey:@"name"];
            
            [self dismissViewControllerAnimated:YES completion:nil];

            NSLog(@"%@--", snsPlatform);
        }});
    
//    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
//        NSLog(@"------SnsInformation is %@",response.data);
//    }];
}

// 下拉退出键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y < - 64) {
        [self.view endEditing:YES];
    }
}
@end
