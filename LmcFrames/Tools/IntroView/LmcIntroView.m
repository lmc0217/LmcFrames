//
//  LmcIntroView.m
//  LmcFrames
//
//  Created by Mr.Chao on 16/1/19.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "LmcIntroView.h"
#import "pageOne.h"
#import "pageTwo.h"
#import "pageThree.h"

@interface LmcIntroView ()<UIScrollViewDelegate>
{
    NSTimer *_timer;
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton *startBtn;

@property (nonatomic, strong) pageOne *pageOne;
@property (nonatomic, strong) pageTwo *pageTwo;
@property (nonatomic, strong) pageThree *pageThree;

@property (nonatomic) BOOL isShowStartBtn;

@end

@implementation LmcIntroView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [self initSubViews];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (void)initSubViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setDelegate:self];
    [_scrollView setPagingEnabled:YES];
    _scrollView.bounces = NO;
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width*3, _scrollView.frame.size.height)];
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self addSubview:_scrollView];
    
    //开始体验按钮
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startBtn.frame = CGRectMake(CGRectGetWidth(self.frame)/2-100, CGRectGetHeight(self.frame)-45, 200, 40);
    _startBtn.layer.cornerRadius = 10;
    _startBtn.layer.masksToBounds = YES;
    [_startBtn setTitle:@"开始体验" forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(startBtnCliced) forControlEvents:UIControlEventTouchUpInside];
    [_startBtn setBackgroundColor:[UIColor blueColor]];
    [_startBtn setHidden:YES];
    [self addSubview:_startBtn];
    
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
    _pageOne = [[pageOne alloc] initWithFrame:CGRectMake(0, 0, width, height)];
//    _pageTwo = [[pageTwo alloc] initWithFrame:CGRectMake(width, 0, width, height)];
//    _pageThree = [[pageThree alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
    [_scrollView addSubview:_pageOne];
//    [_scrollView addSubview:_pageTwo];
//    [_scrollView addSubview:_pageThree];
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-60, self.frame.size.width, 10)];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1.000]];
    [_pageControl setNumberOfPages:3];
    
    float sysVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (sysVersion >= 6.0)
    {
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    //添加当点击小白点就执行的方法
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
}

//自动切换轮播
- (void)autoScrollView
{
    CGFloat width = _scrollView.frame.size.width;
    int totalIndex = _scrollView.contentSize.width/width;
    int currentIndex = _scrollView.contentOffset.x/width;
    [UIView animateWithDuration:1 animations:^{
        CGFloat wid=_scrollView.frame.size.width;
        _scrollView.contentOffset=CGPointMake(wid*(currentIndex+1), 0);
            self.pageControl.currentPage = currentIndex+1;
            [self.pageControl updateCurrentPageDisplay];
    }];
    
    if (currentIndex == totalIndex-2)
    {
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        return;
    }
}

- (void)setIsShowStartBtn:(BOOL)isShowStartBtn
{
    [_startBtn setHidden:isShowStartBtn];
}

- (void)startBtnCliced
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    [self removeFromSuperview];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
//    int totalIndex = _scrollView.contentSize.width/width;
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageIndex = _scrollView.contentOffset.x / pageWidth;
    _pageControl.currentPage = roundf(pageIndex);
//    if (pageIndex < totalIndex) {
//        if (!_timer) {
//            _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
//        }
//    }
//    else
//    {
//        if (_timer) {
//            [_timer invalidate];
//            _timer = nil;
//        }
//    }
    
    if (0 == pageIndex) {
        //
        self.isShowStartBtn = YES;
    }
    if (1 == pageIndex) {
        if (!_pageTwo) {
            _pageTwo = [[pageTwo alloc] initWithFrame:CGRectMake(width, 0, width, height)];
            [_scrollView addSubview:_pageTwo];
            
        }
        self.isShowStartBtn = YES;
    }
    if (2 == pageIndex) {
        if (!_pageThree) {
            _pageThree = [[pageThree alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
            [_scrollView addSubview:_pageThree];
        }
        self.isShowStartBtn = NO;
    }
}


- (void)changePage:(UIPageControl*)pageControl
{
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
    
    int index = roundf(pageControl.currentPage);
    CGPoint point = CGPointMake(index*_scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:point animated:YES];
    
    if (0 == index) {
        //
        self.isShowStartBtn = YES;
    }
    if (1 == index) {
        if (!_pageTwo) {
            _pageTwo = [[pageTwo alloc] initWithFrame:CGRectMake(width, 0, width, height)];
            [_scrollView addSubview:_pageTwo];
            
        }
        self.isShowStartBtn = YES;
    }
    if (2 == index) {
        if (!_pageThree) {
            _pageThree = [[pageThree alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
            [_scrollView addSubview:_pageThree];
        }
        self.isShowStartBtn = NO;
    }
    
}
@end
