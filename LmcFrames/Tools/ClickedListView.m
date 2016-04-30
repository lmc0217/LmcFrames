//
//  ClickedListView.m
//  LmcFrames
//
//  Created by Mr.Chao on 15/11/24.
//  Copyright (c) 2015年 lmc. All rights reserved.
//

#import "ClickedListView.h"

#define  Arror_height 10 //箭头高度

@implementation ClickedListView

- (id)initWithFrame:(CGRect)frame listAry:(NSMutableArray *)listAry
{
    if (self = [super initWithFrame:frame]) {
        _arrData = [NSMutableArray arrayWithArray:listAry];
        [self initSubView];
    }
    return self;
}


- (void)initSubView
{
    self.backgroundColor = [UIColor clearColor];
    //表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Arror_height, self.frame.size.width, self.frame.size.height - Arror_height-1) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.layer.cornerRadius = 6.0;
    _tableView.layer.masksToBounds = YES;
    [self addSubview:_tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arrData && [_arrData count]) {
        return _arrData.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        //image
        UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20.0f, 20.0f)];
        logoImg.tag = 777;
        [cell.contentView addSubview:logoImg];
        //label
        UILabel *atextLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoImg.frame)+5, 0, self.frame.size.width - CGRectGetWidth(logoImg.frame), 30.0f)];
        atextLab.tag = 666;
        atextLab.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:atextLab];
        //line
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29.0, CGRectGetWidth(_tableView.frame), 1)];
        line.backgroundColor = colorwithrgb(234, 234, 234, 1);
        [cell.contentView addSubview:line];
    }
    
    if (_arrData && indexPath.row < [_arrData count]) {
        //图片
        UIImageView *logoView = (UIImageView *)[cell.contentView viewWithTag:777];
        logoView.image = [UIImage imageNamed:[[[_arrData objectAtIndex:indexPath.row] allValues] objectAtIndex:0]];
        //名称
        UILabel *aLab = (UILabel *)[cell.contentView viewWithTag:666];
        aLab.text = [[[_arrData objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    }
    
    return cell;
}


//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(seletedIndex:)]) {
        [_delegate seletedIndex:(int)indexPath.row];
    }
}


#pragma mark - 固定写法， 绘制一个箭头
//绘制文本上下文
-(void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
}

//设置画线路径并画线
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect)+Arror_height, maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(context, midx+40-Arror_height, miny);
    CGContextAddLineToPoint(context,midx+40, miny-Arror_height);
    CGContextAddLineToPoint(context,midx+40+Arror_height, miny);
    
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, minx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextClosePath(context);
}

//重载父类的方法，用于视图绘制(此方法会自动调用，绘制当前视图内容)
- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

@end
