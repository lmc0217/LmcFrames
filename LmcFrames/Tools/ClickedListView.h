//
//  ClickedListView.h
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/24.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

/*=============================
    仿QQ带箭头的下拉菜单
 =============================*/


#import <UIKit/UIKit.h>
@protocol ClickedListViewDelegate <NSObject>

@required
- (void)seletedIndex:(int)index;

@end

@interface ClickedListView : UIView<UITableViewDataSource,UITableViewDelegate>

/**
 *  @breif: 数组arr元素为字典 NSDictionary *dic1 = [NSDictionary dictionaryWithObject:@"imageName" forKey:@"扫一扫"]
 */
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) id<ClickedListViewDelegate>delegate;
/**
 *  @breif: ClickedListView *listView = [[ClickedListView alloc] initWithFrame:CGRectMake(20, 100, 150, [arr count] * 30.0f+10.0f) listAry:arr];
 */
- (id)initWithFrame:(CGRect)frame listAry:(NSMutableArray *)listAry;

@end
