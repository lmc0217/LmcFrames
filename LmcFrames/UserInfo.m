//
//  UserInfo.m
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/20.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initValues];
    }
    return self;
}

- (void)initValues
{
    _account = @"";
    _passwd = @"";
    _userName = @"";
    _userID = @"";
    _companyID = @"";
}
@end
