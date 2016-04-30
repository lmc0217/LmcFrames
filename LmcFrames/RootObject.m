//
//  RootObject.m
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/20.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import "RootObject.h"
#import "SystemTool.h"

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
@end
