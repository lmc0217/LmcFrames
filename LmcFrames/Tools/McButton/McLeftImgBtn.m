//
//  McLeftImgBtn.m
//  LmcFrames
//
//  Created by yespowering on 16/6/12.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "McLeftImgBtn.h"

@implementation McLeftImgBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}


#pragma mark -改变按钮默认图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = 15;
    CGFloat w = 15;
    CGFloat x = 5;
    CGFloat y = (self.frame.size.height - h) * 0.5;
    return CGRectMake(x, y, w, h);
}

#pragma mark -改变按钮默认文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(20, (self.frame.size.height -20) * 0.5, self.frame.size.width-20, 20);
}

@end
