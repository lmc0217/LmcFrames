//
//  ModuleTwoVC.m
//  LmcFrames
//
//  Created by yespowering on 16/5/31.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "ModuleTwoVC.h"
#import "McSearchResultVC.h"

@interface ModuleTwoVC ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *resultAry;
@property (nonatomic, strong) NSMutableArray *tempsAry;

@end

@implementation ModuleTwoVC

- (void)initData
{
    _resultAry = [NSMutableArray array];
    for (int i = 1; i < 16 ; i ++) {
        NSString *str = [NSString stringWithFormat:@"梦超%d个个",i];
        [_resultAry addObject:str];
    }

    _tempsAry = [NSMutableArray array];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.definesPresentationContext = YES;//这句不可少
    [self initData];
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    McSearchResultVC *resultTVC = [[McSearchResultVC alloc] init];
    UINavigationController *resultVC = [[UINavigationController alloc] initWithRootViewController:resultTVC];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
    self.searchController.searchResultsUpdater = self;
    
    //黑色半透明蒙版
    //    self.searchController.dimsBackgroundDuringPresentation = NO;
//        self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x,self.searchController.searchBar.frame.origin.y,self.searchController.searchBar.frame.size.width,44);
    //样式
    self.searchController.searchBar.tintColor = colorwithrgb(52, 222, 136, 1);
    self.searchController.searchBar.backgroundColor = colorwithrgb(234, 234, 234, 1);
    [self.searchController.searchBar setBackgroundImage:[[UIImage alloc] init]];
    self.searchController.searchBar.placeholder = @"搜索";
    
    self.mainTableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.delegate = self;
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier1 = @"mcCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
    }
    cell.textLabel.text = self.resultAry[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//选择表格视图某一行调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES];
    for (UIView *view in [[searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    return YES;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
    McSearchResultVC *resultVC = (McSearchResultVC *)navController.topViewController;
    [self filterContentForSearchText:self.searchController.searchBar.text];
    resultVC.resultsAry = self.tempsAry;
    [resultVC.tableView reloadData];
}

#pragma mark - Private Method
- (void)filterContentForSearchText:(NSString *)searchText{
    NSLog(@"%@",searchText);
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    [self.tempsAry removeAllObjects];
    for (int i = 0; i < self.resultAry.count; i++) {
        NSString *title = self.resultAry[i];
        NSRange storeRange = NSMakeRange(0, title.length);
        NSRange foundRange = [title rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            [self.tempsAry addObject:self.resultAry[i]];
        }
    }
}

@end
