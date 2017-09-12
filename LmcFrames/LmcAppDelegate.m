//
//  AppDelegate.m
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/16.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import "LmcAppDelegate.h"
#import "DDDTouchVC.h"
#import "McUINavigationController.h"
#import "UIImage+Color.h"

@interface LmcAppDelegate ()

@end

@implementation LmcAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //语言设置
//    [McLocalizableCtrl initUserLanguage];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:AppLanguage]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:AppLanguage];
    }
    
    [self configShortCutItems];
//    [[RootObject getRootObject] pushtoMain];
    //要判断，但发现我加上之后通过标签启动时不会加载预览界面
//    if (launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"] == nil)
//    {
        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

- (void)configShortCutItems
{
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay];
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"888" localizedTitle:@"play" localizedSubtitle:@"动态添加的标签" icon:icon1 userInfo:nil];
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"shareIcon"];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"999" localizedTitle:@"自定义图标" localizedSubtitle:@"刘梦超" icon:icon2 userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[item1,item2];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 3D Touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    //判断先前我们设置的唯一标识
    if([shortcutItem.type isEqualToString:@"666"]){
        DDDTouchVC *vc = [[DDDTouchVC alloc] init];
        McUINavigationController *nav_VC = [[McUINavigationController alloc] initWithRootViewController:vc];
        [nav_VC setBackgroundImage:[UIImage imageWithColor:GREENTYPE]];
        //设置当前的VC 为rootVC
        [self.window.rootViewController presentViewController:nav_VC animated:YES completion:^{
        }];
        return;
    }
    if([shortcutItem.type isEqualToString:@"777"]){

        DDDTouchVC *vc = [[DDDTouchVC alloc] init];
        McUINavigationController *nav_VC = [[McUINavigationController alloc] initWithRootViewController:vc];
        [nav_VC setBackgroundImage:[UIImage imageWithColor:GREENTYPE]];
        //设置当前的VC 为rootVC
        [self.window.rootViewController presentViewController:nav_VC animated:YES completion:^{
        }];
        return;
    }
    if ([shortcutItem.type isEqualToString:@"888"]) {
        DDDTouchVC *vc = [[DDDTouchVC alloc] init];
        McUINavigationController *nav_VC = [[McUINavigationController alloc] initWithRootViewController:vc];
        [nav_VC setBackgroundImage:[UIImage imageWithColor:GREENTYPE]];
        //设置当前的VC 为rootVC
        [self.window.rootViewController presentViewController:nav_VC animated:YES completion:^{
        }];
        return;
    }
    if ([shortcutItem.type isEqualToString:@"999"]) {
        NSArray *arr = @[@"hello 3D Touch"];
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:arr applicationActivities:nil];
        //设置当前的VC 为rootVC
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        }];
        return;
    }
}
@end
