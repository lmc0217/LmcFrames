//
//  pageThree.m
//  LmcFrames
//
//  Created by Mr.Chao on 16/1/19.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "pageThree.h"
#import "LmcBlokenLine.h"

@implementation pageThree

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self loadUI];
    }
    return self;
}


- (void)loadUI
{
    LmcBlokenLine *blokenLine = [[LmcBlokenLine alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2-150, 100, 300, 250)];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, CGRectGetHeight(blokenLine.frame))];
    line1.backgroundColor = [UIColor whiteColor];
    [blokenLine addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(blokenLine.frame)-2, CGRectGetWidth(blokenLine.frame), 2)];
    line2.backgroundColor = [UIColor whiteColor];
    [blokenLine addSubview:line2];
    
    [self addSubview:blokenLine];
}
@end
