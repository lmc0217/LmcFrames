//
//  ModuleOneVC.m
//  LmcFrames
//
//  Created by yespowering on 16/5/31.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "ModuleOneVC.h"
#import "DDDTouchVC.h"
#import "ShakeSwitchImgVC.h"

@interface ModuleOneVC ()

@end

@implementation ModuleOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTitle:McLocalizedString(@"msg", @"")];
    [self initData];
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
   
    _arrData = [NSMutableArray array];
    NSArray *arr1 = [NSArray arrayWithObjects:McLocalizedString(@"3DTouch", @""), McLocalizedString(@"moveEvent", @""),nil];
    [_arrData addObject:arr1];
    
    NSArray *arr2 = [NSArray arrayWithObjects:McLocalizedString(@"chinese", @""),McLocalizedString(@"english", @""), nil];
    [_arrData addObject:arr2];
    
    NSArray *arr3 = [NSArray arrayWithObjects:McLocalizedString(@"server", @""),McLocalizedString(@"aboutUS", @""),McLocalizedString(@"contactUS", @""), nil];
    [_arrData addObject:arr3];
    
    NSArray *arr4 = [NSArray arrayWithObjects:McLocalizedString(@"version",@""), nil];
    [_arrData addObject:arr4];
}
- (void)initSubViews
{
    //表格视图
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.bounces = YES;
    
    UIView *aaaView = [[UIView alloc] init];
    aaaView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.tableFooterView = aaaView;
    [self.view addSubview:self.mainTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrData count];
}

//设置表格视图每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arrData && [_arrData count])
    {
        NSArray *array = [_arrData objectAtIndex:section];
        return [array count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"Cell";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell1)
    {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier1];
        //            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor clearColor];
        
        UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, Screen_width-120, 40)];
        detailLab.tag = 666;
        detailLab.font = [UIFont systemFontOfSize:14];
        detailLab.textColor = GRAYCOLOUR;
        detailLab.numberOfLines = 0;
        detailLab.textAlignment = NSTextAlignmentRight;
        [cell1.contentView addSubview:detailLab];
    }
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3) {
        cell1.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section < [_arrData count]) //判断
    {
        NSArray *array = [_arrData objectAtIndex:indexPath.section];
        cell1.textLabel.text = [array objectAtIndex:indexPath.row];
        
    }
    
    return cell1;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mainTableView.frame.size.width, 15)];
    bgView.backgroundColor = colorwithrgb(234, 234, 234, 1);
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01f;
    }
    else
    {
        return 30;
    }
    //    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//选择表格视图某一行调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DDDTouchVC *dddTouchVC = [[DDDTouchVC alloc] init];
            dddTouchVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dddTouchVC animated:YES];
            return;
        }
        if (indexPath.row == 1) {
            ShakeSwitchImgVC *shakeSwitchImgVC = [[ShakeSwitchImgVC alloc] init];
            shakeSwitchImgVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shakeSwitchImgVC animated:YES];
            return;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:AppLanguage];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[RootObject getRootObject] pushtoMain];
            return;
        }
        if (indexPath.row == 1) {
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:AppLanguage];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[RootObject getRootObject] pushtoMain];
            return;
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            //server provision
            
            return;
        }
        if (indexPath.row == 1) {
            
            return;
        }
        if (indexPath.row ==2) {
            //contact us
            
            return;
        }
    }
    else
    {
        
    }
    
}


@end
