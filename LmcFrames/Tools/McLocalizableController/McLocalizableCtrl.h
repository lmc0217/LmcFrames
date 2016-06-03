//
//  McLocalizableCtrl.h
//  LmcFrames
//
//  Created by yespowering on 16/6/3.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface McLocalizableCtrl : NSObject

+ (NSBundle *)bundle;//获取当前资源文件

+ (void)initUserLanguage;//初始化语言文件

+ (NSString *)userLanguage;//获取应用当前语言

+ (void)setUserlanguage:(NSString *)language;//设置当前语言

@end
