//
//  NSString+McMD5.h
//  YPowering
//
//  Created by yespowering on 16/5/14.
//  Copyright © 2016年 yespowering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonDigest.h>

@interface NSString (McMD5)

- (NSString *) md5;
- (NSString *) sha1;


@end
