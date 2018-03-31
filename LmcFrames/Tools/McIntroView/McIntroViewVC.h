//
//  自封装引导页(基于UIPageViewController)
//  McIntroViewVC.h
//  LmcFrames
//
//  Created by chao on 2018/3/31.
//  Copyright © 2018年 lmc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface McIntroViewVC : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic)  UIPageControl *pageControl;
@end
