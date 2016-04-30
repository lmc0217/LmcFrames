//
//  RootObject.h
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/20.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"


@interface RootObject : NSObject

@property (nonatomic, strong) UserInfo *userInfo;//登陆用户管理
@property (nonatomic, strong) NSString *currenVersion;//当前版本号
/*
 *  @breif: 获取RootObject单利对象
 *
 */
+ (RootObject *)getRootObject;

/*
 *  @breif: 自动登录标志,从本地读取
 */
- (BOOL)getAutoLoginFlag;
/*
 *  @breif: 获取用户名和密码,从本地读取
 *  @param [out]: strAccount:账号名 strPasswd:密码
 */
- (void)getAccountName:(NSString **)strAccount password:(NSString **)strPasswd;
/*
 *  @breif: 保存自动登录
 *  @param [in]:bFlag:自动登录标志 strAccount:账号名 strPasswd:密码
 */
- (void)saveAutoLoginFlag:(BOOL)bFlag accountName:(NSString *)strAccount password:(NSString *)strPasswd;


@end

