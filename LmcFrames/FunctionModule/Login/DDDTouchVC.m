//
//  DDDTouchVC.m
//  LmcFrames
//
//  Created by yespowering on 16/4/30.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "DDDTouchVC.h"
#import "DDDTouchPeekVC.h"

@interface DDDTouchVC ()<UIViewControllerPreviewingDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGRect _sourceRect;
    NSIndexPath *_selectedPath;
    
}
@property (nonatomic, retain) NSMutableArray *arrData;
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation DDDTouchVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
#if 0
    //设置代理为nil之后即便自定义了leftBarButtonItem也可以右滑pop。(已封装进McUINavigationController)
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //do somthing ...
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
#endif
}
- (void)viewWillDisappear:(BOOL)animated
{
    if (![[self.navigationController viewControllers] containsObject: self])
    {
        // the view has been removed from the navigation stack, back is probably the cause
        // this will be slow with a large stack however.
        NSLog(@"右滑手势返回");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle:@"3D Touch - 刘梦超"];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 40, 25);
    [back setTitle:@"exit" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    
    [self initTableView];
    
    //检测是否支持3D Touch...
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        //支持
        //        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    else
    {
        //不支持
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你的手机不支持3D Touch..." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)initTableView
{
    NSDictionary *dic1 = [NSDictionary dictionaryWithObject:@"http://a.hiphotos.baidu.com/image/h%3D360/sign=1698b41ebb389b5027ffe654b535e5f1/a686c9177f3e6709e974ebff39c79f3df8dc55bd.jpg" forKey:@"刘梦超-1"];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObject:@"http://b.hiphotos.baidu.com/image/h%3D360/sign=ff34dff8bd389b5027ffe654b537e5f1/a686c9177f3e670900d880193fc79f3df9dc5578.jpg" forKey:@"刘梦超-2"];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObject:@"http://a.hiphotos.baidu.com/image/h%3D360/sign=f527ab2f4b540923b5696578a259d1dc/dcc451da81cb39dbce6b325ad2160924ab183016.jpg" forKey:@"刘梦超-3"];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObject:@"http://d.hiphotos.baidu.com/image/h%3D360/sign=81d5d22779f40ad10ae4c1e5672d1151/d439b6003af33a8762fee505c45c10385343b51a.jpg" forKey:@"刘梦超-4"];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObject:@"http://d.hiphotos.baidu.com/image/h%3D200/sign=8d3a52a04ded2e73e3e9812cb701a16d/f7246b600c33874450b89258560fd9f9d72aa091.jpg" forKey:@"刘梦超-5"];
    NSDictionary *dic6 = [NSDictionary dictionaryWithObject:@"http://h.hiphotos.baidu.com/image/h%3D360/sign=e53dee25d5ca7bcb627bc1298e086b3f/a2cc7cd98d1001e9ae32c3e9ba0e7bec55e797ce.jpg" forKey:@"刘梦超-6"];
    NSDictionary *dic7 = [NSDictionary dictionaryWithObject:@"http://g.hiphotos.baidu.com/image/h%3D360/sign=8cb0e6191a178a82d13c79a6c602737f/6c224f4a20a446230761b9b79c22720e0df3d7bf.jpg" forKey:@"刘梦超-7"];
    NSDictionary *dic8 = [NSDictionary dictionaryWithObject:@"http://a.hiphotos.baidu.com/image/h%3D360/sign=80285822f9f2b211fb2e8348fa806511/bd315c6034a85edf1da1c0724b540923dd5475b5.jpg" forKey:@"刘梦超-8"];
    NSDictionary *dic9 = [NSDictionary dictionaryWithObject:@"http://e.hiphotos.baidu.com/image/h%3D360/sign=708629f379cb0a469a228d3f5b62f63e/7dd98d1001e939015d4a463779ec54e736d1966b.jpg" forKey:@"刘梦超-9"];
    NSDictionary *dic10 = [NSDictionary dictionaryWithObject:@"http://h.hiphotos.baidu.com/image/h%3D360/sign=95102c30bc096b639e1958563c338733/3801213fb80e7beccbb1e8fe2d2eb9389b506b42.jpg" forKey:@"刘梦超-10"];
    NSDictionary *dic11 = [NSDictionary dictionaryWithObject:@"http://a.hiphotos.baidu.com/image/h%3D360/sign=cbd227bf8e5494ee9822091f1df5e0e1/c2cec3fdfc039245ee84470f8594a4c27d1e25f8.jpg" forKey:@"刘梦超-11"];
    NSDictionary *dic12 = [NSDictionary dictionaryWithObject:@"http://e.hiphotos.baidu.com/image/h%3D360/sign=87824d652adda3cc14e4be2631e83905/b03533fa828ba61e64671cd54534970a314e59bb.jpg" forKey:@"刘梦超-12"];
    _arrData = [[NSMutableArray alloc]initWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12, nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 3D Touch
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    
#if 0
    BOOL isWillPeek = [self getShouldShowRectAndIndexPathWithLocation:location];
    
    if (isWillPeek) {
        NSString *imageURL = [[[_arrData objectAtIndex:_selectedPath.row] allValues] objectAtIndex:0];
        DDDTouchPeekVC *peekVC = [[DDDTouchPeekVC alloc] initWithImageURL:imageURL];
        peekVC.view.backgroundColor = [UIColor greenColor];
        
        previewingContext.sourceRect = _sourceRect;
        return peekVC;
    }
    else
    {
        return nil;
    }
#else
    //方法中一定要对每个cell进行注册代理方法:[self registerForPreviewingWithDelegate:self sourceView:cell];
    
    //通过[previewingContext sourceView]拿到对应的cell
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    
    NSString *imageURL = [[[_arrData objectAtIndex:indexPath.row] allValues] objectAtIndex:0];
    DDDTouchPeekVC *peekVC = [[DDDTouchPeekVC alloc] initWithImageURL:imageURL];
    peekVC.view.backgroundColor = [UIColor greenColor];
    
    //设置第一次重按显示的控制器大小
    peekVC.preferredContentSize = CGSizeMake(0, 300);
//    NSLog(@"%@",location);
    return peekVC;
#endif
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    viewControllerToCommit.hidesBottomBarWhenPushed = YES;
    [self showViewController:viewControllerToCommit sender:self];
    //    [self.navigationController pushViewController:viewControllerToCommit animated:NO];
}




/*
 *  获取用户手势点所在cell的下标，同时判断手势点是否超出tableview的范围
 */
#pragma mark - 较精确地获取高亮Rect
- (BOOL)getShouldShowRectAndIndexPathWithLocation:(CGPoint)location {
    //坐标点的转化，
    CGPoint tableLocation = [self.view convertPoint:location toView:self.tableView];
    _selectedPath = [self.tableView indexPathForRowAtPoint:tableLocation];
    //    // 根据手指按压的区域，结合 tableView 的 Y 偏移量（上下）
    //    location.y = _tableView.contentOffset.y+location.y;
    //    //定位到当前，按压的区域处于哪个 cell  获得 cell 的indexPath
    //    _selectedPath = [_tableView indexPathForRowAtPoint:location];
    // 根据cell 的indexPath 取出 cell
    UITableViewCell * cell = [_tableView cellForRowAtIndexPath:_selectedPath];
    //    cell.backgroundColor = [UIColor redColor];
    // 根据获得cell，确定高亮的区域，记得高亮区域是相对于屏幕位置来算，记得减去tableView的Y偏移量
    _sourceRect = CGRectMake(cell.frame.origin.x, cell.frame.origin.y-_tableView.contentOffset.y, cell.frame.size.width,cell.frame.size.height);
    // 如果row越界了，返回NO 不处理peek手势
    return (_selectedPath && _selectedPath.row < _arrData.count) ? YES : NO;
    
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arrData && _arrData.count > 0) {
        return _arrData.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LMChao";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //注册Peek高亮来源
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    
    if (_arrData && indexPath.row < [_arrData count])
    {
        cell.textLabel.text = [[[_arrData objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //do somthing...
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *imageURL = [[[_arrData objectAtIndex:indexPath.row] allValues] objectAtIndex:0];
    DDDTouchPeekVC *peekVC = [[DDDTouchPeekVC alloc] initWithImageURL:imageURL];
    [self.navigationController pushViewController:peekVC animated:YES];
}


#if 0
//右滑手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
#endif

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
}
@end
