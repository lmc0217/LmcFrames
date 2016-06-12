//
//  MultilevelCellVC.m
//  LmcFrames
//
//  Created by yespowering on 16/6/12.
//  Copyright © 2016年 lmc. All rights reserved.
//

#import "MultilevelCellVC.h"
#import "McLeftImgBtn.h"

@interface MultilevelCellVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;//section标题
@property(nonatomic, strong)NSMutableArray *selectedArray;//是否被点击
@end

@implementation MultilevelCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTitle:@"二级列表展开"];
    [self initData];
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 ,0 , self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)initData
{
    NSArray *arr1 = [NSArray arrayWithObjects:@"Andriod", @"IOS",nil];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObject:arr1 forKey:@"我的设备"];
    
    NSArray *arr2 = [NSArray arrayWithObjects:@"路人甲",@"路人乙",@"路人丙",@"路人丁", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObject:arr2 forKey:@"我的好友"];
    
    NSArray *arr3 = [NSArray arrayWithObjects:@"小明",@"小红",@"小悠", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObject:arr3 forKey:@"小学"];
    
    NSArray *arr4 = [NSArray arrayWithObjects:@"大X", @"大胖", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObject:arr4 forKey:@"大学好友"];
    _dataArray = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4, nil];
    _selectedArray = [NSMutableArray array];
    for (int i = 0; i < _dataArray.count; i++) {
        //
        [_selectedArray addObject:@"0"];
    }
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断section的标记是否为1,如果是说明为展开,就返回真实个数,如果不是就说明是缩回,返回0.
    if ([_selectedArray[section] isEqualToString:@"1"]) {
        return [[[_dataArray[section] allValues] objectAtIndex:0] count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textColor = colorwithrgb(152, 152, 152, 1);
    }
    NSDictionary *dic = _dataArray[indexPath.section];
    NSArray *arr = [[dic allValues] objectAtIndex:0];
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    return cell;
}





#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //每个section上面有一个button,给button一个tag值,用于在点击事件中改变_selectedArray[button.tag - 1000]的值
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 40)];
    sectionView.backgroundColor = [UIColor whiteColor];
    McLeftImgBtn *sectionButton = [[McLeftImgBtn alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 39)];
    [sectionButton setTitle:[[[_dataArray objectAtIndex:section] allKeys] objectAtIndex:0] forState:UIControlStateNormal];
    [sectionButton setImage:[UIImage imageNamed:@"msg_left_icon"] forState:UIControlStateNormal];
    [sectionButton setImage:[UIImage imageNamed:@"msg_left_icon"] forState:UIControlStateHighlighted];
//    [sectionButton setTitleColor:colorwithrgb(152, 152, 152, 1) forState:UIControlStateNormal];
    [sectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    sectionButton.tag = 1000 + section;
    [sectionView addSubview:sectionButton];
    
    //分割线
    UIView *theLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39, CGRectGetWidth(_tableView.frame), 1)];
    theLine.backgroundColor = colorwithrgb(234, 234, 234, 1);
    [sectionView addSubview:theLine];
    
    return sectionView;
}

//选择表格视图某一行调用的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark button点击方法
-(void)buttonAction:(UIButton *)button
{
    if ([_selectedArray[button.tag - 1000] isEqualToString:@"0"]) {

        //如果当前点击的section是缩回的,那么点击后就需要把它展开,是_selectedArray对应的值为1,这样当前section返回cell的个数就变为真实个数,然后刷新这个section就行了
        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"1"];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"0"];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
