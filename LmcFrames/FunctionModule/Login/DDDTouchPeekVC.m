//
//  DDDTouchPeekVC.m
//  LmcFrames
//
//  Created by Mr.Chao on 16/3/10.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "DDDTouchPeekVC.h"

@interface DDDTouchPeekVC ()
{
    UIImageView *_potoView;
}

@property (nonatomic, copy) NSString *etag;
@end

@implementation DDDTouchPeekVC

- (id)initWithImageURL:(NSString *)imageURL
{
    if (self = [super init]) {
        //do somthing..
        _imageURL = imageURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 40, 25);
    [back setTitle:@"back" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    
    self.title = @"3D Touch PeekVC";
    
    _potoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    [self.view addSubview:_potoView];

    [self initData];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    if (![[self.navigationController viewControllers] containsObject: self])
    {
        // the view has been removed from the navigation stack, back is probably the cause
        // this will be slow with a large stack however.
        NSLog(@"右滑手势返回");
    }
}
- (void)backButtonClicked
{
    //右键返回时也会走 右滑手势返回
    NSLog(@"右键返回");
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)initData
{
    
    NSURL *url = [NSURL URLWithString:_imageURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10.0];
    
    if (self.etag.length > 0) {
        [request setValue:self.etag forHTTPHeaderField:@"IF-None-Match"];
    }
    

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        
        NSLog(@"%@",httpResponse);
        
        if (error.code == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //显示图片
                _potoView.image = [UIImage imageWithData:data];
            });
        }
        
        self.etag = httpResponse.allHeaderFields[@"etag"];
        NSLog(@"%@",httpResponse.allHeaderFields);
        
    }];
    [task resume];
}


#pragma mark - 底部预览界面选项
- (NSArray <id <UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"呵呵" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"%s",__func__);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"呵呵" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"嘿嘿" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"%s",__func__);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"嘿嘿" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"刘梦超" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"%s",__func__);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"刘梦超..." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    //想要显示多个就定义多个 UIPreviewAction
    NSArray *actions = @[action1,action2,action3];
    return actions;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 以下两个为默认设定，直接复制粘贴就行(好像可有可无)
// 根视图的返回
- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
}
// 根视图的类型
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end
