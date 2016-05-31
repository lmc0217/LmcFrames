//
//  NSDictionary+safe.h
//  lmcFrames
//
//  Created by Mr.chao on 16-5-23.
//  Copyright (c) 2016年 lmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDictionary (safe)

- (NSString *)safeStringForKey:(id)aKey;
- (NSInteger)safeIntegerForKey:(id)aKey;
- (CGFloat)safeFloatForKey:(id)aKey;

@end