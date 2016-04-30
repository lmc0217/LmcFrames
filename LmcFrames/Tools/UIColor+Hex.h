//
//  UIColor+Hex.h
//  LmcFrames
//
//  Created by Mr.Chao on 16/3/14.
//  Copyright © 2016年 lmc. All rights reserved.
//
/*=============================
 颜色处理类别，可显示 #0493DD 色值
 =============================*/

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(id)input;

@end
