//
//  ShakeSwitchImageView.m
//  LmcFrames
//
//  Created by yespowering on 16/5/31.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "ShakeSwitchImageView.h"
#import "UIImage+Color.h"

@implementation ShakeSwitchImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image=[self getRandomImage];
    }
    return self;
}

#pragma mark -设置控件成为第一响应者
-(BOOL)canBecomeFirstResponder{
    return YES;
}

#pragma mark 运动开始
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion==UIEventSubtypeMotionShake) {
        self.image=[self getRandomImage];
    }
}
#pragma mark 运动结束
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}


#pragma mark 随机取得图片
-(UIImage *)getRandomImage{
    int index= arc4random()%4;
    UIImage *image;
    if (index == 0) {
        image = [UIImage imageWithColor:GREENCOLOUR];
    }
    if (index == 1) {
        image = [UIImage imageWithColor:REDCOLOUR];
    }
    if (index == 2) {
        image = [UIImage imageNamed:@"icon1"];
    }
    if (index == 3) {
        image = [UIImage imageWithColor:GRAYCOLOUR];
    }
    
    return image;
}
@end
