//
//  LmcItemsView.m
//  LmcFrames
//
//  Created by Mr.Chao on 16/1/19.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "LmcItemsView.h"

@interface LmcItemsView ()
{
    UILabel *_titleLab;
}

@end

@implementation LmcItemsView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
        [self loadUI];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLab.text = title;
}

- (void)loadUI
{
    //do somthing...
    _titleLab = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:20];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = @"";
    _titleLab.textColor = [UIColor whiteColor];
    [self addSubview:_titleLab];
}

@end
