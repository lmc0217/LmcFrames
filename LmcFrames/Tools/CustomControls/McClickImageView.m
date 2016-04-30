//
//  McClickImageView.m
//  LmcFrames
//
//  Created by Mr.Chao on 15/12/22.
//  Copyright © 2015年 lmc. All rights reserved.
//

#import "McClickImageView.h"
#import <objc/message.h>

// 运行时objc_msgSend
#define McClickImageViewMsgSend(...) ((void (*)(void *, SEL, UIImageView *))objc_msgSend)(__VA_ARGS__)
#define McClickImageViewMsgTarget(target) (__bridge void *)(target)

@implementation McClickImageView

- (void)addTarget:(id)target clickAction:(SEL)action;
{
    self.userInteractionEnabled = YES;
    _clickTarget = target;
    _clickAction = action;
    
    //一个手指单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
    [self addGestureRecognizer:singleTap];
}


- (void)clickView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_clickTarget respondsToSelector:_clickAction]) {
            McClickImageViewMsgSend(McClickImageViewMsgTarget(_clickTarget), _clickAction, self);
        }
    });
}
@end
