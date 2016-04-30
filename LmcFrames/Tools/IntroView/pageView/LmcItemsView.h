//
//  LmcItemsView.h
//  LmcFrames
//
//  Created by Mr.Chao on 16/1/19.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmcItemsView : UIImageView

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGPoint farPoint;
@property (nonatomic) CGPoint nearPoint;

@property (nonatomic, strong) NSString *title;
@end
