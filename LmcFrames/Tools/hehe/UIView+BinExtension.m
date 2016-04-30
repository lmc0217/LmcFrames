//
//  UIView+BinExtension.m
//  LuoHuJianKang
//
//  Created by Mr Bin on 15/11/10.
//  Copyright (c) 2015年 深圳兰德科技有限公司. All rights reserved.
//

#import "UIView+BinExtension.h"

@implementation UIView (BinExtension)

- (CGFloat)bin_height
{
    return self.frame.size.height;
}

- (void)setBin_height:(CGFloat)bin_height
{
    CGRect temp = self.frame;
    temp.size.height = bin_height;
    self.frame = temp;
}

- (CGFloat)bin_width
{
    return self.frame.size.width;
}

- (void)setBin_width:(CGFloat)bin_width
{
    CGRect temp = self.frame;
    temp.size.height = bin_width;
    self.frame = temp;
}

- (CGFloat)bin_x
{
    return self.frame.origin.x;
}

- (void)setBin_x:(CGFloat)bin_x
{
    CGRect temp = self.frame;
    temp.origin.x = bin_x;
    self.frame = temp;
}

- (CGFloat)bin_y
{
    return self.frame.origin.y;
}

- (void)setBin_y:(CGFloat)bin_y
{
    CGRect temp = self.frame;
    temp.origin.x = bin_y;
    self.frame = temp;
}



@end
