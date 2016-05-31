//
//  McBaseViewController.m
//  LmcFrames
//
//  Created by Mr.chao on 16/4/21.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "McBaseViewController.h"

@interface McBaseViewController ()

@end

@implementation McBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initNavigationTitle];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -初始化导航栏标题
- (void)initNavigationTitle
{
    _customTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 21)];
    _customTitleLabel.userInteractionEnabled = NO;
    _customTitleLabel.font = [UIFont boldSystemFontOfSize:20];
    _customTitleLabel.textAlignment = NSTextAlignmentCenter;
    _customTitleLabel.textColor = [UIColor colorWithRed:(255)/255.0f green:(255)/255.0f blue:(255)/255.0f alpha:1];
    _customTitleLabel.autoresizesSubviews = YES;
    _customTitleLabel.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _customTitleLabel;
}


#pragma mark - 设置背景颜色
- (void)setBackgroundImage:(NSString *)imageName
{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = [UIImage imageNamed:imageName];
    backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:backgroundImageView];
}


#pragma mark- 设置导航栏title
- (void)setCustomTitle:(NSString *)title
{
    /*
    [_customTitleLabel setText:title];
     */
    self.title = title;
}


#pragma mark -界面提示框
- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message cancelTitle:(NSString*)cancelTitle
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:title
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:cancelTitle
                                         otherButtonTitles:nil];
    [alert show];
}


#pragma mark-设置左边导航栏按钮
- (void)setLeftNavBarItem:(NSString *)normalImage
                highImage:(NSString *)highImage
                    width:(CGFloat)width
                   height:(CGFloat)height
                   action:(SEL)action
                      tag:(CGFloat)tag
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, width, height);
    leftBtn.tag = tag;
    [leftBtn setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark-设置右边导航栏按钮
- (void)setRightNavBarItem:(NSString *)normalImage
                 highImage:(NSString *)highImage
                     width:(CGFloat)width
                    height:(CGFloat)height
                    action:(SEL)action
                       tag:(CGFloat)tag
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, width, height);
    rightBtn.tag = tag;
    [rightBtn setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark -设置右边导航栏文字
- (void)setRightNavBarItem:(NSString *)title
                  fontSize:(CGFloat)fontSize
                    action:(SEL)action
                       tag:(CGFloat)tag
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    rightBtn.titleLabel.textColor = [UIColor whiteColor];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    rightBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [rightBtn setTitle:title forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    rightBtn.titleLabel.numberOfLines = 0;
    rightBtn.tag = tag;
    [rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}



@end
