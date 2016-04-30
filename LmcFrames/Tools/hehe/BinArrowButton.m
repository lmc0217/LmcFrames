//
//  BinArrowButton.m
//  LuoHuJianKang
//
//  Created by Mr Bin on 15/12/22.
//  Copyright (c) 2015年 深圳兰德科技有限公司. All rights reserved.
//

#import "BinArrowButton.h"
#import "UIView+BinExtension.h"

@implementation BinArrowButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

#pragma mark -改变按钮默认图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = 15;
    CGFloat w = 8;
    CGFloat x = self.bin_width * 0.5 + w + 5;
    CGFloat y = (self.bin_height - h) * 0.5;
    return CGRectMake(x, y, w, h);
}

#pragma mark -改变按钮默认文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, (self.bin_height-20)*0.5, self.bin_width*0.5-5, 20);
}

@end
