//
//  MBProgressHUD+MC.m
//  LmcFrames
//
//  Created by yespowering on 16/5/10.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "MBProgressHUD+MC.h"

@implementation MBProgressHUD (MC)


/**
 *  显示文本
 *
 *  @param text 信息内容
 *  @param view 显示的视图
 */
+ (void)showText:(NSString *)text toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    //The animation type that should be used when the HUD is shown and hidden.
    hud.animationType = MBProgressHUDAnimationZoomOut;
    //蒙版(方法已换，但还能用)
//    hud.dimBackground = YES;
    hud.label.text = text;
//    hud.label.textColor = [UIColor whiteColor];
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, 0.f);
    
    [hud hideAnimated:YES afterDelay:2.f];
}
/**
 *  显示文本
 *
 *  @param text 信息内容
 */
+ (void)showText:(NSString *)text
{
    [self showText:text toView:nil];
}
/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    hud.label.text = text;
    //正方形
    hud.square = YES;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:0.7];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

/**
 *  显示loading...
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showLoading:(NSString *)message
{
    return [self showLoading:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showLoading:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    hud.label.text = message;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

@end
