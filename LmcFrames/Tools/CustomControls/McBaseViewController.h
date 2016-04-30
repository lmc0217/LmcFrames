//
//  McBaseViewController.h
//  LmcFrames
//
//  Created by Mr.chao on 16/4/21.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface McBaseViewController : UIViewController
{
    UILabel *_customTitleLabel;
}

//设置背景颜色
- (void)setBackgroundImage:(NSString*)imageName;


//设置导航栏标题
- (void)setCustomTitle:(NSString*)title;


//设置导航栏左边按钮
- (void)setLeftNavBarItem:(NSString *)normalImage
                highImage:(NSString *)highImage
                    width:(CGFloat)width
                   height:(CGFloat)height
                   action:(SEL)action
                      tag:(CGFloat)tag;

//设置导航栏右边按钮
- (void)setRightNavBarItem:(NSString *)normalImage
                 highImage:(NSString *)highImage
                     width:(CGFloat)width
                    height:(CGFloat)height
                    action:(SEL)action
                       tag:(CGFloat)tag;


//设置导航栏右边文字
- (void)setRightNavBarItem:(NSString*)title
                  fontSize:(CGFloat)fontSize
                    action:(SEL)action
                       tag:(CGFloat)tag;

//提示框
- (void)showAlertWithTitle:(NSString*)title
                   message:(NSString*)message
               cancelTitle:(NSString*)cancelTitle;

@end
