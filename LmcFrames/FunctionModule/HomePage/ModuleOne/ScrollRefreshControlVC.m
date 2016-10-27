//
//  ScrollRefreshControlVC.m
//  LmcFrames
//
//  Created by yespowering on 2016/10/27.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "ScrollRefreshControlVC.h"

@interface ScrollRefreshControlVC ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@end

@implementation ScrollRefreshControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTitle:@"IOS 10.ScrolView自带刷新"];
    [self initData];
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews
{
    //scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height-64)];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    CGFloat width = _scrollView.bounds.size.width;
    CGFloat height = _scrollView.bounds.size.height;
    _scrollView.contentSize = CGSizeMake(width, height);
    //IOS 10新特性
    _scrollView.refreshControl = [[UIRefreshControl alloc] init];
    //frame 没发现起作用
     _scrollView.refreshControl.frame = CGRectMake(0, 0, Screen_width, 64);
    //前景色：菊花转的颜色
    _scrollView.refreshControl.tintColor = [UIColor cyanColor];
    //添加标题
    _scrollView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    //背景色：刷新控制器的背景
    _scrollView.refreshControl.backgroundColor = [UIColor whiteColor];
    //响应事件
    [_scrollView.refreshControl addTarget:self action:@selector(refreshEvent) forControlEvents:UIControlEventValueChanged];
    //refresh
    [self.view addSubview:_scrollView];
    
}

- (void)initData
{
    
    
}
#pragma mark -响应事件
- (void)refreshEvent
{
    NSLog(@"加载新数据");
    _scrollView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新中..."];
//    [_scrollView.refreshControl endRefreshing];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


#pragma mark - UIRefreshControl的开始刷新的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"即将开始拖拽");
    _scrollView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"即将开始减速");
    _scrollView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新完成"];
}
#pragma mark - UIRefreshControl的停止刷新的方法
#if 1  //停止下拉拖拽后立即停止刷新
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_scrollView.refreshControl endRefreshing];
}
#endif
@end
