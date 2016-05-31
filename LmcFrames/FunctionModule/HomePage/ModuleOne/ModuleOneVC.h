//
//  ModuleOneVC.h
//  LmcFrames
//
//  Created by yespowering on 16/5/31.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "McBaseViewController.h"

@interface ModuleOneVC : McBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *arrData;
@end
