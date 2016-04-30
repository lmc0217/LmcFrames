//
//  SystemTool.h
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/20.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import "LmcAppDelegate.h"

//系统版本
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7 (SystemVersion>=7.0 ? YES : NO)

//获取屏幕宽、高
#define Screen_width ([UIScreen mainScreen].bounds.size.width)
#define Screen_height ([UIScreen mainScreen].bounds.size.height)
//定义颜色宏
#define colorwithrgb(x, y, z, alp) [UIColor colorWithRed:(x)/255.0 green:(y)/255.0 blue:(z)/255.0 alpha:(alp)]
/*
 *  @brief: 获取内存剩余容量，单位MB
 */
long long getFreeSpaceInKB();

/*
 * @brief 获得全局的delegate
 */
LmcAppDelegate *getAppDelegate();

/*
 *  @brief:返回非Null字符串, 如果str是NSNull则返回@“”
 */
NSString *getSafeString(NSString *str);