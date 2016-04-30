//
//  RollingView.m
//  LmcFrames
//
//  Created by Mr.Chao on 16/2/1.
//  Copyright © 2016年 lmc. All rights reserved.
//
/*============================================
                功能:跑马灯效果视图
                time:2016.2.1
                by:MengChao Liu
 ============================================*/
#import "RollingView.h"


@interface RollingView ()

@property(nonatomic,strong) NSTimer* timer;//定时器
@property(nonatomic,weak) UILabel *customLab;

@end
@implementation RollingView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //do somthing...
        CGRect frame = self.frame;
        frame.size.height = 40.0f;
        self.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        self.layer.masksToBounds = YES;
        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    CGFloat customLabY = (self.frame.size.height - 30)/2;
    UILabel *customLab = [[UILabel alloc] init];
    customLab.frame = CGRectMake(self.frame.size.width, customLabY, 100, 30);
    [customLab setTextColor:[UIColor whiteColor]];
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.customLab = customLab;
    //添加视图
    [self addSubview:customLab];
}


- (void) changePoints
{
    CGPoint curPoints = self.customLab.center;
    // 当curPoints的maxX坐标已经超过了屏幕的宽度
    if(curPoints.x+CGRectGetWidth(_customLab.frame)/2 < 0)
    {
        CGFloat distance = self.customLab.frame.size.width/2;
        // 控制再次从屏幕左侧开始移动
        self.customLab.center = CGPointMake(self.frame.size.width + distance, self.frame.size.height/2);
        
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            //animation...
            self.customLab.center = CGPointMake(curPoints.x - 4, 20);
        } completion:^(BOOL finished) {
            //finish..
        }];
        
    }
}

- (void)setShowTitle:(NSString *)showTitle
{
    if (![showTitle isEqual:[NSNull class]]) {
        _customLab.text = showTitle;
        CGFloat width = [self textWidth:_customLab];
        CGFloat customLabY = (self.frame.size.height - 30)/2;
        _customLab.frame = CGRectMake(self.frame.size.width, customLabY, width, 30);
        
        // 启动NSTimer定时器来改变_customLab的位置
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(changePoints)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

#pragma mark - 文本宽度计算
- (CGFloat)textWidth:(UILabel*)lable
{
    NSDictionary *attribute = @{NSFontAttributeName:lable.font};
    CGSize size = [lable.text boundingRectWithSize:CGSizeMake(MAXFLOAT, lable.frame.size.height)
                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:attribute context:nil].size;
    return size.width;
}
@end
