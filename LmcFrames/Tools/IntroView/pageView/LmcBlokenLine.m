//
//  LmcBlokenLine.m
//  LmcFrames
//
//  Created by Mr.Chao on 16/1/19.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "LmcBlokenLine.h"

#define MAX_X_COUNT 7

@interface LmcBlokenLine ()
{
    CGFloat _maxYPower;
}
@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation LmcBlokenLine

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //do somthing...
        _maxYPower = 250;
        self.backgroundColor = [UIColor clearColor];
        [self addDataToArr:50];
        [self addDataToArr:90];
        [self addDataToArr:150];
        [self addDataToArr:100];
        [self addDataToArr:160];
        [self addDataToArr:140];
        [self addDataToArr:200];
        [self setNeedsDisplay];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetLineWidth(context, 2);                                 //设置画笔宽度
//    CGContextSetFillColorWithColor(context, [self.backgroundColor = [UIColor clearColor] CGColor]);  //设置背景填充颜色
//    CGContextFillRect(context, rect);                                           //填充背景
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);              //设置画笔颜色
    
    //arr 为实时获取的动态数据数组
    for (int i = 0; i < _arr.count; i ++) {
        if (i < _arr.count - 1) {
            CGPoint pp[2];
            [_arr[i] getBytes:&pp[0] length:sizeof(CGPoint)];
            [_arr[i+1] getBytes:&pp[1] length:sizeof(CGPoint)];
            
            CGContextMoveToPoint(context, pp[0].x, pp[0].y);
            CGContextAddLineToPoint(context, pp[1].x, pp[1].y);
            CGContextStrokePath(context);
        }
    }
}

- (void)addDataToArr:(CGFloat)data {
    if (!_arr)
        _arr = [[NSMutableArray alloc] init];
    
    CGPoint point;
    //MAX_X_COUNT表示在X轴上显示的最大个数，超过后则X轴向左移动，每次移动一个单位
    if (_arr.count >= MAX_X_COUNT) {
        //移动x轴
        CGRect frame = self.frame;
        frame.origin.x -= (self.frame.size.width / MAX_X_COUNT);
        frame.size.width += (self.frame.size.width / MAX_X_COUNT);
        self.frame = frame;
    }
    point.x = _arr.count * (self.frame.size.width / (MAX_X_COUNT-1));
    
    //如果当前值大于Y轴所代表的最大值，则将Y轴最大值扩大为当前值的2倍
    if (data > _maxYPower) {        //改变y的最大值为currentPower
        _maxYPower = data * 2;
    }
//    point.y = data;
    point.y = CGRectGetHeight(self.frame)-data;
    
    //将实时获取的数据存入_arr中
    [_arr addObject:[NSData dataWithBytes:&point length:sizeof(CGPoint)]];
}

@end
