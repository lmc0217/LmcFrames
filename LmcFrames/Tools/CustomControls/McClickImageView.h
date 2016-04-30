//
//  McClickImageView.h
//  LmcFrames
//
//  Created by Mr.Chao on 15/12/22.
//  Copyright © 2015年 lmc. All rights reserved.
//

/*=================================
    图片按钮，UIImageView加上点击手势
 =================================*/

#import <UIKit/UIKit.h>

@interface McClickImageView : UIImageView

/** 设置回调对象和回调方法 */
- (void)addTarget:(id)target clickAction:(SEL)action;
/** 回调对象 */
@property (weak, nonatomic) id clickTarget;
/** 回调方法 */
@property (assign, nonatomic) SEL clickAction;

@end
