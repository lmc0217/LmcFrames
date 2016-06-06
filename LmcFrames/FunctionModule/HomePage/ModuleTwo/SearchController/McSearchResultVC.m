//
//  McSearchResultVC.m
//  LmcFrames
//
//  Created by yespowering on 16/6/6.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "McSearchResultVC.h"

@interface McSearchResultVC ()

@end

@implementation McSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubViews];
    
}

- (void)initSubViews
{
    //表格视图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    
    UIView *aaaView = [[UIView alloc] init];
    aaaView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = aaaView;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier1 = @"resultCell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    }
    cell.textLabel.text = self.resultsAry[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.resultsAry[indexPath.row];
    //UIAlertController
    UIAlertController *isDeleteAlert = [UIAlertController alertControllerWithTitle:@"弹窗" message:title preferredStyle:UIAlertControllerStyleAlert];
    //添加按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
        NSLog(@"取消");
    }];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        NSLog(@"确定");
//        [self.navigationController dismissViewControllerAnimated:YES completion:^{
//            
//        }];
    }];
    
    [isDeleteAlert addAction:cancelAction];
    [isDeleteAlert addAction:yesAction];
    [self.navigationController presentViewController:isDeleteAlert animated:YES completion:^{
        //
    }];
}

@end
