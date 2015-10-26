//
//  WMHomeViewController.m
//  闪电外卖
//
//  Created by 朱波 on 15/10/25.
//  Copyright © 2015年 WM. All rights reserved.
//

#import "WMHomeViewController.h"
#define kImageCount 5

@interface WMHomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) UIScrollView *scrollViewPic;
@property (strong, nonatomic) UIPageControl *pageControlPic;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation WMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置ScrollView
    [self scrollViewPic];
    [self setupScrollViewPic];
    
}
#pragma mark - TableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


#pragma mark - ScrollView
- (UIScrollView *)scrollViewPic
{
    if (_scrollViewPic == nil) {
        _scrollViewPic = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 130)];
        _scrollViewPic.backgroundColor = [UIColor redColor];
        
        [self.view addSubview:_scrollViewPic];
        
        // 取消弹簧效果
        _scrollViewPic.bounces = NO;
        
        // 取消水平滚动条
        _scrollViewPic.showsHorizontalScrollIndicator = NO;
        _scrollViewPic.showsVerticalScrollIndicator = NO;
        
        // 要分页
        _scrollViewPic.pagingEnabled = YES;
        
        // contentSize
        _scrollViewPic.contentSize = CGSizeMake(kImageCount * _scrollViewPic.bounds.size.width, 0);
        
        // 设置代理
        _scrollViewPic.delegate = self;
    }
    return _scrollViewPic;
}

- (UIPageControl *)pageControlPic
{
    if (_pageControlPic == nil) {
        // 分页控件，本质上和scrollView没有任何关系，是两个独立的控件
        _pageControlPic = [[UIPageControl alloc] init];
        // 总页数
        _pageControlPic.numberOfPages = kImageCount;
        // 控件尺寸
        CGSize size = [_pageControlPic sizeForNumberOfPages:kImageCount];
        
        _pageControlPic.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControlPic.center = CGPointMake(self.view.center.x, 120);
        _pageControlPic.userInteractionEnabled = NO;
        _pageControlPic.alpha = 0.5;
        
        // 设置颜色
        _pageControlPic.pageIndicatorTintColor = [UIColor grayColor];
        _pageControlPic.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        [self.view addSubview:_pageControlPic];
        
        // 添加监听方法
        /** 在OC中，绝大多数"控件"，都可以监听UIControlEventValueChanged事件，button除外" */
        [_pageControlPic addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControlPic;
}

- (void)setupScrollViewPic
{
    // 设置图片
    for (int i = 0; i < kImageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"img_%02d", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollViewPic.bounds];
        imageView.image = image;
        
        [self.scrollViewPic addSubview:imageView];
    }
    
    // 计算imageView的位置
    [self.scrollViewPic.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        
        // 调整x => origin => frame
        CGRect frame = imageView.frame;
        frame.origin.x = idx * frame.size.width;
        
        imageView.frame = frame;
    }];
    //    NSLog(@"%@", self.scrollView.subviews);
    
    // 分页初始页数为0
    self.pageControlPic.currentPage = 0;
    
    // 启动时钟
    [self startTimer];
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer
{
    // 页号发生变化
    // (当前的页数 + 1) % 总页数
    int page = (self.pageControlPic.currentPage + 1) % kImageCount;
    self.pageControlPic.currentPage = page;
    
    // 调用监听方法，让滚动视图滚动
    [self pageChanged:self.pageControlPic];
}

// 分页控件的监听方法
- (void)pageChanged:(UIPageControl *)page
{
    // 根据页数，调整滚动视图中的图片位置 contentOffset
    CGFloat x = page.currentPage * self.scrollViewPic.bounds.size.width;
    [self.scrollViewPic setContentOffset:CGPointMake(x, 0) animated:YES];
}


// 滚动视图停下来，修改页面控件的小点（页数）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[self.view class]]) return;
    // 计算页数
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControlPic.currentPage = page;
}


@end
