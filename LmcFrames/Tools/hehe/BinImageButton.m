//
//  BinImageButton.m
//  LuoHuJianKang
//
//  Created by Mr Bin on 15/12/1.
//  Copyright (c) 2015年 深圳兰德科技有限公司. All rights reserved.
//

#import "BinImageButton.h"

#define colorwithrgb(x, y, z, alp) [UIColor colorWithRed:(x)/255.0 green:(y)/255.0 blue:(z)/255.0 alpha:(alp)]

@implementation BinImageButton

- (id)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title buttonTag:(NSInteger)buttonTag
{
    if (self = [super initWithFrame:frame])
    {
        _buttonTag = buttonTag;
        _buttonImage = imageName;
        _buttonTitle = title;
        [self initSubView];
    }
    return self;
}

#pragma mark -初始化子视图
- (void)initSubView
{
    self.btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
    self.btnImage.center = CGPointMake(self.frame.size.width/2-25, self.frame.size.height/2);
    self.btnImage.contentMode = UIViewContentModeScaleToFill;
    self.btnImage.image = [UIImage imageNamed:_buttonImage];
    [self addSubview:self.btnImage];
    
    self.btnTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-40, 40)];
    self.btnTitle.center = CGPointMake(self.frame.size.width/2+30, self.frame.size.height/2);
    self.btnTitle.numberOfLines = 1;
    self.btnTitle.textColor = colorwithrgb(71, 179, 253, 1);
    self.btnTitle.font = [UIFont boldSystemFontOfSize:14];
    self.btnTitle.text = _buttonTitle;
    [self addSubview:self.btnTitle];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.bounds;
    btn.tag = _buttonTag;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)buttonClick:(UIButton*)btn
{
    self.buttonClickWithTag(btn.tag);
}


#pragma mark -设置图片大小
- (void)setBtnImageFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat heigth = frame.size.height;
    self.btnImage.frame = CGRectMake(0, 0, width, heigth);
    self.btnImage.center = CGPointMake(self.center.x-width/2-10, self.center.y);
}


#pragma mark -设置文字大小
- (void)setBtnTitleFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat heigth = frame.size.height;
    self.btnTitle.frame = CGRectMake(0, 0, width, heigth);
    self.btnTitle.center = CGPointMake(self.center.x+width/2+10, self.center.y);
}




@end
