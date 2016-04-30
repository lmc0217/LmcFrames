//
//  McUINavigationController.m
//  LmcFrames
//
//  Created by Mr.Chao on 16/3/14.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "McUINavigationController.h"

@implementation McUINavigationController

- (void)setBackgroundImage:(UIImage *)image
{
    if (image == nil)
        return;
    UIImage *backgroundImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarPosition:barMetrics:)])
    {
        //if iOS 5.0 and later
        [self.navigationBar setBackgroundImage:backgroundImage forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        if (IOS7)
        {
            self.navigationController.navigationBar.translucent = YES;
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[self.navigationBar viewWithTag:10];
        if (imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithImage:backgroundImage];
            [imageView setTag:10];
            [self.navigationBar insertSubview:imageView atIndex:0];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //设置导航栏标题颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    //设置代理为nil之后即便自定义了leftBarButtonItem也可以右滑pop。
    
    __weak McUINavigationController *weakSelf = self;
//    if ([weakSelf respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //do somthing ...
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    self.delegate = (id)weakSelf;
//    }
}


// Hijack the push method to disable the gesture
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
        self.interactivePopGestureRecognizer.enabled = NO;
//    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


//横竖屏转换
#pragma mark - Orientation

- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

@end