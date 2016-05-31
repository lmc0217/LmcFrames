//
//  UIView+McGetNavgationVC.m
//  YPowering
//
//  Created by yespowering on 16/4/22.
//  Copyright © 2016年 yespowering. All rights reserved.
//

#import "UIView+McGetNavgationVC.h"

@implementation UIView (McGetNavgationVC)


- (UINavigationController *)getNavigationController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}
@end
