//
//  UIImage+Color.m
//  YPowering
//
//  Created by yespowering on 16/5/18.
//  Copyright © 2016年 yespowering. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

//用色值生成图片
+ (UIImage*) imageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
