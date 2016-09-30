//
//  Arrow.m
//  LmcFrames
//
//  Created by yespowering on 2016/9/30.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "Arrow.h"

#define  Arror_height 10 //箭头高度

@implementation Arrow

#pragma mark - 固定写法， 绘制一个箭头
//绘制文本上下文
-(void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
}

//设置画线路径并画线
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 3.0;
    
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(context, midx-Arror_height, maxy);
    CGContextAddLineToPoint(context,midx, maxy-Arror_height);
    CGContextAddLineToPoint(context,midx+Arror_height, maxy);
    
    CGContextAddArcToPoint(context, maxx, maxy, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, miny, minx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, midx-Arror_height, maxy, radius);
    CGContextClosePath(context);
}

//重载父类的方法，用于视图绘制(此方法会自动调用，绘制当前视图内容)
- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

@end
