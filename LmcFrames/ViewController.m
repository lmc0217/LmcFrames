//
//  ViewController.m
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/16.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import "ViewController.h"
#import "ClickedListView.h"
#import "McClickImageView.h"
#import <AddressBook/AddressBook.h>
#import "BinRadioButton.h"
#import "LmcIntroView.h"
#import "RollingView.h"
#import "MCPayAlertView.h"
#import "DDDTouchVC.h"
#import "UIColor+Hex.h"
#import "McUINavigationController.h"
#import "Reachability.h"
#import "McNetworking.h"
#import "CircularProgressView.h"
@interface ViewController ()<ClickedListViewDelegate>

@end

@implementation ViewController
//利用Reachability检测是否有网络
- (BOOL)isHaveNetWork
{
    return([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    //是否有网络
    if ([self isHaveNetWork]) {
        NSLog(@"有网络");
    }
    else
    {
        NSLog(@"没有网络");
    }
    //网络监测
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    CircularProgressView *progressView = [[CircularProgressView alloc] initWithFrame:CGRectMake(20, 100, 150, 150)];
    progressView.progress = 0.0;
    [self.view addSubview:progressView];
    
#if 0
    NSDictionary *dic1 = [NSDictionary dictionaryWithObject:@"icon1" forKey:@"扫一扫"];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObject:@"icon1" forKey:@"加好友"];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObject:@"icon1" forKey:@"创建讨论组"];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObject:@"icon1" forKey:@"发送到电脑"];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObject:@"icon1" forKey:@"面对面快传"];
    NSDictionary *dic6 = [NSDictionary dictionaryWithObject:@"icon1" forKey:@"支付"];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6, nil];
    ClickedListView *listView = [[ClickedListView alloc] initWithFrame:CGRectMake(20, 100, 150, [arr count] * 30.0f+10.0f) listAry:arr];
    listView.delegate = self;
    [self.view addSubview:listView];
    
    McClickImageView *clickView = [[McClickImageView alloc] initWithFrame:CGRectMake(100*layout(), 300*layout(), 40*layout(), 40*layout())];
    clickView.image = [UIImage imageNamed:@"icon1"];
    clickView.tag = 777;
    [clickView addTarget:self clickAction:@selector(clickeView:)];
    [self.view addSubview:clickView];

    BinRadioButton *clickView2 = [BinRadioButton buttonWithType:UIButtonTypeCustom];
    clickView2.frame = CGRectMake(100, 340, 150, 30);
    clickView2.backgroundColor = [UIColor colorWithHexString:@"#0493DD"];
    //    [clickView2 setBackgroundImage:[UIImage imageNamed:@"select.jpg"] forState:UIControlStateNormal];
    [clickView2 setImage:[UIImage imageNamed:@"select.jpg"] forState:UIControlStateHighlighted];
    [clickView2 setImage:[UIImage imageNamed:@"noSelect.jpg"] forState:UIControlStateNormal];
    [clickView2 setTitle:NSLocalizedString(@"ButtonTile", nil) forState:UIControlStateNormal];
    clickView2.tag = 888;
    [clickView2 addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickView2];
    
#endif
#if 0
    //长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    longPressGesture.minimumPressDuration = 1;//最小长按时间
    longPressGesture.numberOfTouchesRequired = 1;//一个手指长按
    [self.view addGestureRecognizer:longPressGesture];
    
    //跑马灯效果滚动文字
    RollingView *rollingView = [[RollingView alloc] initWithFrame:CGRectMake(0, 0, 200, 10)];
    rollingView.center = self.view.center;
    rollingView.tag = 1111;
    rollingView.showTitle = @"乱纷纷像一首朦胧诗，懵懂懂才懂得朦胧美。只要我以为，就不是误会，谁都是宝贝，有什么真伪，什么是是非，都似是而非,醉眼看世界，世界随我陶醉...";
    [self.view addSubview:rollingView];
#endif
    
#if 0
    //引导页
    LmcIntroView *intoView = [[LmcIntroView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:intoView];
    
#endif
    
#if 0
    //获取通讯录权限
    [self signGetTel];
    
#endif
    
}

- (void)pushVC
{
    DDDTouchVC *dddTouchVC = [[DDDTouchVC alloc] init];
    McUINavigationController *nav_VC = [[McUINavigationController alloc] initWithRootViewController:dddTouchVC];
    [nav_VC setBackgroundImage:[UIImage imageNamed:@"nav_bg"]];
    [self presentViewController:nav_VC animated:YES completion:^{
        //
    }];
}
- (void)clickeView:(McClickImageView *)clickView
{
    int a = (int)clickView.tag;
    if ( a== 777) {
        NSLog(@"第一个");
        
        CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:M_PI],[NSNumber numberWithFloat:0.0f], nil];
        rotateAnimation.duration = 2.0f;
        rotateAnimation.keyTimes = [NSArray arrayWithObjects:
                                    [NSNumber numberWithFloat:.3],
                                    [NSNumber numberWithFloat:.4], nil];
        
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration = 2.0f;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, CGRectGetMidX(clickView.frame), CGRectGetMidY(clickView.frame));
        //    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
        //    CGPathAddLineToPoint(path, NULL, item.nearPoint.x, item.nearPoint.y);
        CGPathAddLineToPoint(path, NULL, 200, 400);
//        CGPathAddLineToPoint(path, NULL, CGRectGetMidX(clickView.frame), CGRectGetMidY(clickView.frame));
        positionAnimation.path = path;
        CGPathRelease(path);
        
        CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
        animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, rotateAnimation, nil];
        animationgroup.duration = 2.0f;
        animationgroup.fillMode = kCAFillModeForwards;
        animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [clickView.layer addAnimation:animationgroup forKey:@"hehe"];
        
        clickView.center = CGPointMake(200, 400);
        
    }
    if ( a == 888) {
        NSLog(@"第二个");
    }
}

- (void)showMenu:(UILongPressGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    
    [self becomeFirstResponder];
    //长按菜单
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    UIMenuItem *menuItem1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(theCopy)];
    UIMenuItem *menuItem2 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(theDele)];
    UIMenuItem *menuItem3 = [[UIMenuItem alloc] initWithTitle:@"移动" action:@selector(theMove)];
    menuController.menuItems = [NSArray arrayWithObjects: menuItem1, menuItem2,menuItem3, nil];
//    menuController.arrowDirection = UIMenuControllerArrowLeft;
    [menuController setTargetRect:CGRectMake(point.x, point.y, 50, 50) inView:self.view];//point.x, point.y,分别为长按那点的x和y坐标   self.view为将要展示弹出框的视图
    [menuController setMenuVisible:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)signGetTel
{
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    int __block tip=0;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook =nil;
    //因为在IOS6.0之后和之前的权限申请方式有所差别，这里做个判断
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        //创建通讯簿的引用
        addBook=ABAddressBookCreateWithOptions(NULL, NULL);
        //创建一个出事信号量为0的信号
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        //申请访问权限
        ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
            //greanted为YES是表示用户允许，否则为不允许
            if (!greanted) {
                tip=1;
            }
            //发送一次信号
            dispatch_semaphore_signal(sema);
        });
        //等待信号触发
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        //IOS6之前
        addBook =ABAddressBookCreate();
    }
    if (tip) {
        //做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请设置APP访问通讯录权限\n设置>隐私" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return;
    }
    CFRelease(addBook);
}
#pragma mark - ClickedListViewDelegate


- (void)seletedIndex:(int)index
{
    NSLog(@"%d",index);
    if (index == 0) {
        
        [MBProgressHUD showText:@"卧泥玛卧泥玛……"];
        NSString *url = @"http://api.hudong.com/iphonexml.do";
        NSDictionary *parameters = @{@"type":@"focus-c"};
       [McNetworking getWithUrl:url params:parameters success:^(id response) {
           //
           NSLog(@"%@",response);
       } fail:^(NSError *error) {
           //
           NSLog(@"%@",error);
       }];
    }
    if (index == 1) {
//        
        [MBProgressHUD showLoading:nil];//只显示菊花
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), SYS_SERIAL_QUEUE, ^{
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"擦擦"];
            
        });
        
    }
    if (index == 2) {
        //
        [MBProgressHUD showLoading:@"加载中"];
        // 几秒后消失,当前，这里可以改为网络请求
        NSString *url = @"http://59.188.86.204:8000/API/city";
        NSDictionary *parameters = @{@"p":@"{\"a\":1,\"b\":1}"};
        
        [McNetworking postWithUrl:url params:parameters success:^(id response) {
            //
            NSLog(@"%@", response);
            // 移除HUD
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"加载成功"];
        } fail:^(NSError *error) {
            //
            NSLog(@"Error: %@", error);
            // 移除HUD
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"加载失败"];
        }];
        
        
        
    }
    if (index == 5) {
        //
        MCPayAlertView *payAlert = [[MCPayAlertView alloc] init];
        payAlert.title = @"请输入支付密码";
        payAlert.detail = @"提现";
        payAlert.amount= 99999.9;
        [payAlert show];
        payAlert.completeHandle = ^(NSString *inputPwd) {
            NSLog(@"密码是%@",inputPwd);
        };
    }
}


#pragma mark - UIMenuController
- (void)theCopy
{
    NSLog(@"copy copy copy ");
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];//黏贴板
    [pasteBoard setString:@"卧泥玛， 卧泥玛"];
    NSLog(@"%@",pasteBoard.string);//获得剪贴板的内容
}

- (void)theDele
{
    NSLog(@"copy dele dele ");
    RollingView *aView = (RollingView *)[self.view viewWithTag:1111];
    [aView removeFromSuperview];
    aView = nil;
}
- (void)theMove
{
    NSLog(@"copy copy copy ");
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];//黏贴板
    [pasteBoard setString:@"卧泥玛， 卧泥玛"];
    NSLog(@"%@",pasteBoard.string);//获得剪贴板的内容
}


-(BOOL)canBecomeFirstResponder{
    
    return YES;
    
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if (action ==@selector(theCopy) || action == @selector(theDele) || action == @selector(theMove)){
        
        return YES;
        
    }
    
    return NO;//隐藏系菜单项
}
@end
