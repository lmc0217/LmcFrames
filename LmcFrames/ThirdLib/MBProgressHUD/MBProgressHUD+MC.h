//
//  MBProgressHUD+MC.h
//  LmcFrames
//
//  Created by yespowering on 16/5/10.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MC)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
