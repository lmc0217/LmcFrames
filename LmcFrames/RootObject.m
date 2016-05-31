//
//  RootObject.m
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/20.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import "RootObject.h"
#import "McUINavigationController.h"
#import "UIImage+Color.h"
#import "ModuleOneVC.h"
#import "ModuleTwoVC.h"
#import "ModuleThreeVC.h"
#import "ModuleFourVC.h"

@implementation RootObject

+ (RootObject *)getRootObject;
{
    static dispatch_once_t once;
    static RootObject * _self;
    dispatch_once( &once, ^{ _self = [[RootObject alloc] init]; } );
    return _self;
}
- (id)init
{
    if (self = [super init])
    {
        [self initValues];
    }
    return self;
}

//初始化变量数据。重新登录时需先初始化数据
- (void)initValues
{
    _userInfo = [[UserInfo alloc] init];
    
    
    //为属性设置初始值，防止没有数据时程序崩溃
    //获取系统版本号
    _currenVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

#pragma mark - 自动登陆
- (BOOL)getAutoLoginFlag
{
    BOOL bFlag = NO;
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSNumber *numAutoLoginFlag = [def objectForKey:@"kAutoLoginFlag"];
    if (numAutoLoginFlag == nil || [numAutoLoginFlag isKindOfClass:[NSNull class]])
    {
        bFlag = NO;
    }
    else
    {
        bFlag = numAutoLoginFlag.boolValue;
    }
    return bFlag;
    
}

- (void)getAccountName:(NSString **)pStrAccount password:(NSString **)pStrPasswd
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    *pStrAccount = [def objectForKey:@"kAccount"];
    *pStrPasswd = [def objectForKey:@"kPassword"];
}

- (void)saveAutoLoginFlag:(BOOL)bFlag accountName:(NSString *)strAccount password:(NSString *)strPasswd
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSNumber *numAutoLoginFlag = [NSNumber numberWithBool:bFlag];
    [def setObject:numAutoLoginFlag forKey:@"kAutoLoginFlag"];
    [def setObject:strAccount forKey:@"kAccount"];
    [def setObject:strPasswd forKey:@"kPassword"];
    
    [def synchronize];
}
#pragma mark - 切换界面
/*
 *  @breif: 推出tabbar
 */
-(void)pushtoMain
{
    ModuleOneVC *aVC = [[ModuleOneVC alloc] init];
    aVC.title = @"消息";
    aVC.tabBarItem.image = [UIImage imageNamed:@"msg_n"];
    aVC.tabBarItem.selectedImage = [UIImage imageNamed:@"msg_s"];
    [aVC.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [aVC.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    ModuleTwoVC *bVC = [[ModuleTwoVC alloc] init];
    bVC.title = @"发现";
    bVC.tabBarItem.image = [UIImage imageNamed:@"find_n"];
    bVC.tabBarItem.selectedImage = [UIImage imageNamed:@"find_s"];
    [bVC.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [bVC.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    ModuleThreeVC *cVC = [[ModuleThreeVC alloc] init];
    cVC.title = @"我";
    cVC.tabBarItem.image = [UIImage imageNamed:@"me_n"];
    cVC.tabBarItem.selectedImage = [UIImage imageNamed:@"me_s"];
    [cVC.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [cVC.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    NSArray *array = @[aVC,bVC,cVC];
    
    NSMutableArray *viewcontrollers = [[NSMutableArray alloc] initWithCapacity:3];
    
    for (int i = 0; i < 3; i ++) {
        McUINavigationController *nav = [[McUINavigationController alloc] initWithRootViewController:[array objectAtIndex:i]];
        [nav setBackgroundImage:[UIImage imageWithColor:GREENTYPE]];
        [viewcontrollers addObject:nav];
    }
    
    UITabBarController *tabbarVC = [[UITabBarController alloc] init];
    tabbarVC.viewControllers =viewcontrollers;
    
    [tabbarVC.tabBar setTintColor:GREENTYPE];
    
    //    CATransition *animation = [CATransition animation];
    //    animation.duration = 0.3;
    //    animation.type = kCATransitionPush;
    //    animation.subtype = kCATransitionFromRight;
    //    [getAppDelegate().window.layer addAnimation:animation forKey:@"animation"];
    getAppDelegate().window.rootViewController = tabbarVC;
}
@end
