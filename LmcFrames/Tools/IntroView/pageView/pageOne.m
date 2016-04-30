//
//  pageOne.m
//  LmcFrames
//
//  Created by Mr.Chao on 16/1/19.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "pageOne.h"
#import "LmcItemsView.h"

#define NEARRADIUS 130.0f//最近动画半径
#define ENDRADIUS 180.0f//最终动画半径(离球的实际距离)
#define FARRADIUS 200.0f//最远动画半径
#define EndTPOINT CGPointMake([UIScreen mainScreen].bounds.size.width-80, [UIScreen mainScreen].bounds.size.height-250)//中间球位置
#define TIMEOFFSET 0.026f//每个小球动画间隔时间

@interface pageOne ()

@property (nonatomic, retain) LmcItemsView *item_1;
@property (nonatomic, retain) LmcItemsView *item_2;
@property (nonatomic, retain) LmcItemsView *item_3;
@property (nonatomic, retain) LmcItemsView *item_4;
@property (nonatomic, retain) LmcItemsView *item_5;
@end

@implementation pageOne

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
    UIImageView *mainView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    mainView.center = CGPointMake(CGRectGetWidth(self.frame)-80, CGRectGetHeight(self.frame)-250);
    mainView.backgroundColor = [UIColor yellowColor];
    mainView.layer.cornerRadius = 50;
    mainView.layer.masksToBounds = YES;
    [self addSubview:mainView];
    
    
    //items...
//    _item_1 = [[LmcItemsView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    NSArray *titleAry = [NSArray arrayWithObjects:@"货物5", @"货物4", @"货物3", @"货物2", @"货物1", nil];
    int count = (int)[titleAry count];
    for (int i = 0; i < count; i ++)
    {
        LmcItemsView *item = [[LmcItemsView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        item.tag = 1000 + i;
        item.endPoint = EndTPOINT;
//        item.startPoint = CGPointMake(EndTPOINT.x - ENDRADIUS * sinf(i * M_PI_2 / (count - 1)), EndTPOINT.y - ENDRADIUS * cosf(i * M_PI_2 / (count - 1)));
        item.startPoint = CGPointMake(EndTPOINT.x - ENDRADIUS * sinf(i * M_PI_2 / (count - 1)), EndTPOINT.y - (ENDRADIUS + i * 20) * cosf(i * M_PI_2 / (count - 1)));
        item.nearPoint = CGPointMake(EndTPOINT.x - NEARRADIUS * sinf(i * M_PI_2 / (count - 1)), EndTPOINT.y - NEARRADIUS * cosf(i * M_PI_2 / (count - 1)));
        item.farPoint = CGPointMake(EndTPOINT.x - FARRADIUS * sinf(i * M_PI_2 / (count - 1)), EndTPOINT.y - FARRADIUS * cosf(i * M_PI_2 / (count - 1)));
        item.center = item.startPoint;
        item.backgroundColor = [UIColor purpleColor];
        item.layer.cornerRadius = 30;
        item.layer.masksToBounds = YES;
        item.title = [titleAry objectAtIndex:i];
        [self addSubview:item];
        [self animationView:item];
        
    }
    
    
    
}

- (void)animationView:(LmcItemsView *)view
{
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:M_PI * 2],[NSNumber numberWithFloat:0.0f], nil];
    rotateAnimation.duration = 0.5f;
    rotateAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:.0],
                                [NSNumber numberWithFloat:.4],
                                [NSNumber numberWithFloat:.5], nil];
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 1.0f;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(view.frame), CGRectGetMidY(view.frame));
    CGPathAddLineToPoint(path, NULL, view.farPoint.x, view.farPoint.y);
    CGPathAddLineToPoint(path, NULL, view.nearPoint.x, view.nearPoint.y);
    CGPathAddLineToPoint(path, NULL, view.endPoint.x, view.endPoint.y);
    positionAnimation.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, rotateAnimation, nil];
    animationgroup.duration = 2.0f;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer addAnimation:animationgroup forKey:@"close"];
    
    view.center = view.endPoint;
//    [self sendSubviewToBack:view];
    
    //隐藏
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:4.0];
    view.alpha = 0;
    [UIView commitAnimations];
}
@end
