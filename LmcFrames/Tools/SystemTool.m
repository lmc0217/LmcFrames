//
//  SystemTool.m
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/20.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import "SystemTool.h"
#import <sys/mount.h>


/*
 * @brief 获得全局的delegate
 */
LmcAppDelegate *getAppDelegate()
{
    return (LmcAppDelegate *)[[UIApplication sharedApplication] delegate];
}

long long getFreeSpaceInKB()
{
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    struct statfs tStats;
    //    statfs([[paths lastObject] cString], &tStats);
    statfs("/var", &tStats);
    
    long long totalSpace = (long long)(tStats.f_bfree * tStats.f_bsize);
    
    return totalSpace / 1024;
}

NSString *getSafeString(NSString *str)
{
    if ([str isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    return str;
}