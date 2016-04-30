//
//  BinTextField.m
//  LuoHuJianKang
//
//  Created by Mr Bin on 15/12/14.
//  Copyright (c) 2015年 深圳兰德科技有限公司. All rights reserved.
//

#import "BinTextField.h"
#define colorwithrgb(x, y, z, alp) [UIColor colorWithRed:(x)/255.0 green:(y)/255.0 blue:(z)/255.0 alpha:(alp)]

@implementation BinTextField

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.cornerRadius = 3.0f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = colorwithrgb(183, 183, 183, 1).CGColor;
        self.layer.masksToBounds = YES;
        [self setLeftPadding];
    }
    return self;
}

#pragma mark -设置左边
- (void)setLeftPadding
{
    CGRect frame = self.frame;
    frame.size.width = 7.0f;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}



@end
