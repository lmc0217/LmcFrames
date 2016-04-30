//
//  BinImageButton.h
//  LuoHuJianKang
//
//  Created by Mr Bin on 15/12/1.
//  Copyright (c) 2015年 深圳兰德科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickWtihTag)(NSInteger tag);

@interface BinImageButton : UIView
{
    NSInteger _buttonTag;
    NSString *_buttonImage;
    NSString *_buttonTitle;
}

@property (nonatomic, copy) ButtonClickWtihTag buttonClickWithTag;
@property (nonatomic, strong) UIImageView *btnImage;
@property (nonatomic, strong) UILabel *btnTitle;

- (id)initWithFrame:(CGRect)frame
          imageName:(NSString*)imageName
              title:(NSString*)title
          buttonTag:(NSInteger)buttonTag;

//设置按钮图片
- (void)setBtnImageFrame:(CGRect)frame;

//设置按钮标题
- (void)setBtnTitleFrame:(CGRect)frame;

@end
