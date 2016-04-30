//
//  BinButton.m
//  LuoHuJianKang
//
//  Created by Mr Bin on 15/11/10.
//  Copyright (c) 2015年 深圳兰德科技有限公司. All rights reserved.
//

#import "BinButton.h"
#import "UIView+BinExtension.h"

@implementation BinButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#pragma mark -改变按钮默认图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = self.bin_height * 0.5;
    CGFloat w = h;
    CGFloat x = (self.bin_width - w) * 0.5;
    CGFloat y = self.bin_width * 0.15;
    return CGRectMake(x, y, w, h);
}

#pragma mark -改变按钮默认文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.bin_height * 0.65, self.bin_width, self.bin_height * 0.3);
}

@end
