//
//  NSDictionary+safe.m
//  lmcFrames
//
//  Created by Mr.chao on 16-5-23.
//  Copyright (c) 2016年 lmc. All rights reserved.
//

#import "NSDictionary+safe.h"

@implementation NSDictionary (safe)

- (NSString *)safeStringForKey:(id)aKey
{
    NSString *strRet = [self objectForKey:aKey];
    if (![strRet isKindOfClass:[NSString class]])
    {
        strRet = @"";
    }
    return strRet;
}

- (NSInteger)safeIntegerForKey:(id)aKey
{
    NSNumber *numberRet = [self objectForKey:aKey];
    if (![numberRet isKindOfClass:[NSNumber class]])
    {
        if ([numberRet isKindOfClass:[NSString class]])
        {
            NSString *strRet = (NSString *)numberRet;
            return [strRet integerValue];
        }
        return 9999;
    }
    return numberRet.integerValue;
}

- (CGFloat)safeFloatForKey:(id)aKey
{
    NSNumber *numberRet = [self objectForKey:aKey];
    if (![numberRet isKindOfClass:[NSNumber class]])
    {
        if ([numberRet isKindOfClass:[NSString class]])
        {
            NSString *strRet = (NSString *)numberRet;
            return [strRet floatValue];
        }
        return 9999.9;
    }
    return numberRet.floatValue;
}

@end