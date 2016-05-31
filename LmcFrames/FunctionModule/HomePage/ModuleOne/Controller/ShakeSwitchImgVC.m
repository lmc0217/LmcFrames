//
//  ShakeSwitchImgVC.m
//  LmcFrames
//
//  Created by yespowering on 16/5/31.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "ShakeSwitchImgVC.h"
#import "ShakeSwitchImageView.h"

@interface ShakeSwitchImgVC ()
{
    ShakeSwitchImageView *_imageView;
}
@end

@implementation ShakeSwitchImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTitle:@"摇一摇"];
    _imageView=[[ShakeSwitchImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _imageView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    _imageView.layer.cornerRadius = 50;
    _imageView.layer.masksToBounds = YES;
    _imageView.userInteractionEnabled=true;
    [self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 显示时让控件变成第一响应者
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [_imageView becomeFirstResponder];
}

#pragma mark 不显示时注销控件第一响应者
-(void)viewDidDisappear:(BOOL)animated{
    [_imageView resignFirstResponder];
}

/*视图控制器的运动事件*/
//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    NSLog(@"motion begin...");
//}
//
//-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    NSLog(@"motion end.");
//}
@end
