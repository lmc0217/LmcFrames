//
//  McSearchResultVC.h
//  LmcFrames
//
//  Created by yespowering on 16/6/6.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "McBaseViewController.h"

@interface McSearchResultVC : McBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
// 搜索结果数据
@property (nonatomic, strong) NSMutableArray *resultsAry;
@end
