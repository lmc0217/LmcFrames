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
//全局绿色颜色
#define GREENTYPE [UIColor colorWithRed:52/255.0 green:222/255.0 blue:136/255.0 alpha:1]
#define MSGCONTENTLOUR [UIColor colorWithRed:233/255.0 green:252/255.0 blue:241/255.0 alpha:1]

#define GRAYCOLOUR [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1]
#define GREENCOLOUR [UIColor colorWithRed:103/255.0 green:184/255.0 blue:64/255.0 alpha:1]
#define BROWNCOLOUR [UIColor colorWithRed:244/255.0 green:151/255.0 blue:86/255.0 alpha:1]
#define REDCOLOUR [UIColor colorWithRed:212/255.0 green:31/255.0 blue:37/255.0 alpha:1]

// 系统子线程池(并发执行)
#define SYS_CONCURRENT_QUEUE_H  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
#define SYS_CONCURRENT_QUEUE_D  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define SYS_CONCURRENT_QUEUE_L  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
#define SYS_CONCURRENT_QUEUE_B  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)

// 系统主线程池(序列执行)
#define SYS_SERIAL_QUEUE      dispatch_get_main_queue()
#define SYS_UI_QUEUE          dispatch_get_main_queue()

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