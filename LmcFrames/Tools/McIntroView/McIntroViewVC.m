//
//  McIntroViewVC.m
//  LmcFrames
//
//  Created by chao on 2018/3/31.
//  Copyright © 2018年 lmc. All rights reserved.
//

#import "McIntroViewVC.h"
#import "IntroViewVC_1.h"
#import "IntroViewVC_2.h"
#import "IntroViewVC_3.h"

@interface McIntroViewVC ()
@property (strong, nonatomic) NSArray *pages;
@property (strong, nonatomic) UIPageViewController *pageController;
@end

@implementation McIntroViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    self.pages =@[
                  [[IntroViewVC_1 alloc]init],
                  [[IntroViewVC_2 alloc]init],
                  [[IntroViewVC_3 alloc]init]
                  ];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self.pageController setDelegate:self];
    [self.pageController setDataSource:self];
    
    [[self.pageController view] setFrame:[[self view] bounds]];
    NSArray *viewControllers = [NSArray arrayWithObject:[self.pages objectAtIndex:0]];
    [self.pageControl setCurrentPage:0];
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    
    [self.view addSubview:self.pageControl];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [self.view sendSubviewToBack:[self.pageController view]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];
    if ( currentIndex < [self.pages count]-1) {
        return [self.pages objectAtIndex:currentIndex+1];
    } else {
        return nil;
    }
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger currentIndex = [self.pages indexOfObject:viewController];
    if ( currentIndex > 0) {
        return [self.pages objectAtIndex:currentIndex-1];
    } else {
        return nil;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSUInteger currentIndex = [self.pages indexOfObject:pageViewController.viewControllers[0]];
    [self.pageControl setCurrentPage:currentIndex];
}

-(void)buildUI
{
    // init pageControl
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    [self.pageControl setBounds:CGRectMake(0,0,16*(4-1)+16,16)]; //页面控件上的圆点间距基本在16左右。
    [self.pageControl.layer setCornerRadius:8]; // 圆角层
    [self.pageControl setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.2]];
    [self.view addSubview:self.pageControl];
    
    self.pageControl.frame=CGRectMake(50, 200, 40, 80);
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    self.pageControl.backgroundColor = [UIColor clearColor];
    [self.pageControl setCurrentPage:0];
    
}

- (void)changePage:(id)sender {
    
    UIViewController *visibleViewController = self.pageController.viewControllers[0];
    NSUInteger currentIndex = [self.pages indexOfObject:visibleViewController];
    
    NSArray *viewControllers = [NSArray arrayWithObject:[self.pages objectAtIndex:self.pageControl.currentPage]];
    
    if (self.pageControl.currentPage > currentIndex) {
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    } else {
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
        
    }
}

@end
