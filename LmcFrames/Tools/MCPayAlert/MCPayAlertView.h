//
//  MCPayAlertView.h
//  LmcFrames
//
//  Created by Mr.Chao on 16/2/15.
//  Copyright © 2016年 lmc. All rights reserved.
//
/*============================================
                功能:仿微信6位支付界面
                time:2016.2.15
                by:MengChao Liu
 ============================================*/
#import <UIKit/UIKit.h>

@interface MCPayAlertView : UIView

@property (nonatomic, copy) NSString *title, *detail;
@property (nonatomic, assign) CGFloat amount;

@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd);

- (void)show;

@end
