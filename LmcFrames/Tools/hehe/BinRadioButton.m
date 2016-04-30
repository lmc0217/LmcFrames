//
//  BinRadioButton.m
//  LuoHuJianKang
//
//  Created by Mr Bin on 15/12/6.
//  Copyright (c) 2015年 深圳兰德科技有限公司. All rights reserved.
//

#import "BinRadioButton.h"
#import "UIView+BinExtension.h"

@implementation BinRadioButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}


#pragma mark -改变按钮默认图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = 15;
    CGFloat w = 15;
    CGFloat x = 0;
    CGFloat y = (self.bin_height - h) * 0.5;
    return CGRectMake(x, y, w, h);
}

#pragma mark -改变按钮默认文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(20, (self.bin_height -20) * 0.5, self.bin_width-20, 20);
}

@end
