//
//  SYYearViewController.m
//  UP2019
//
//  Created by Yunis on 2019/3/12.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "SYYearViewController.h"
#import "NSDate+index.h"
#import "LineProcessView.h"

@interface SYYearViewController ()

@end

@implementation SYYearViewController


- (void)creatTipWithTitle:(NSString *)title originY:(float)y font:(UIFont *)font process:(float )process
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, CGRectGetWidth(self.view.frame) - 40, 60)];
    label.font = font;
    label.text = title;
    label.textColor = [UIColor colorWithHexString:@"#6b5a53"];//586e75  2aa198  b58900  268bd2
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];

    LineProcessView *p1 = [[LineProcessView alloc] initWithFrame:CGRectMake(20, y + 60, CGRectGetWidth(self.view.frame) - 40, 20)];
    p1.processValue = process;
    p1.fillColor = [UIColor colorWithHexString:@"#6b5a53"]; //#859900
    p1.defaultColor = [UIColor colorWithHexString:@"#a4897e"];//2aa198
    [self.view addSubview:p1];
}
#pragma mark - Life Cycle
//系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载页面
    [self assignDate];
    [self settingAppearance];
    [self loadSubViews];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //布局
}
#pragma mark - Intial Methods
//初始化数据
- (void)assignDate {
    
}

- (void)settingAppearance {
    self.view.backgroundColor = [UIColor colorWithHexString:@"#dacfcb"];

}

- (void)loadSubViews {
    float originY = 100;
    
    [self creatTipWithTitle:[NSString stringWithFormat:@"%@年%@月%@日",[NSDate year],[NSDate month],[NSDate day]] font:[UIFont fontWithName:@"MyanmarSangamMN-Bold" size:24] originY:originY];
    originY += 60;
    
    [self creatTipWithTitle:[NSString stringWithFormat:@"今天是今年的第 %d 天，%@ 年已经过去 %.2f%%",[NSDate indexOfYear],[NSDate year],[NSDate percentOfYear]*100] font:nil originY:originY];
    originY += 60;
    [self creatWithProcess:[NSDate percentOfYear] originY:originY];
    originY += 30;
    
    [self creatTipWithTitle:[NSString stringWithFormat:@"今天是这个月的第 %d 天， %@ 月已经过去 %.2f%%",[NSDate indexOfMonth],[NSDate month],[NSDate percentOfMonth]*100] font:nil originY:originY];
    originY += 60;
    [self creatWithProcess:[NSDate percentOfMonth] originY:originY];
    originY += 30;
    
    
    [self creatTipWithTitle:[NSString stringWithFormat:@"今天是周 %@ ，本周已经过去 %.2f%%",[NSDate weekdayString],[NSDate percentOfWeek]*100] font:nil originY:originY];
    originY += 60;
    [self creatWithProcess:[NSDate percentOfWeek] originY:originY];
    originY += 30;

}



#pragma mark - Target Methods
//点击事件

#pragma mark - Network Methods
//网络请求

#pragma mark - Public Method
//外部方法

#pragma mark - Private Method
//私有方法
- (void)creatTipWithTitle:(NSString *)title font:(UIFont *)font originY:(float)y
{
    if (!font) {
        font = [UIFont fontWithName:@"MyanmarSangamMN-Bold" size:18];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, CGRectGetWidth(self.view.frame) - 40, 60)];
    label.font = font;
    label.text = title;
    label.textColor = [UIColor colorWithHexString:@"#6b5a53"];//586e75  2aa198  b58900  268bd2
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
}

- (void)creatWithProcess:(float )process originY:(float)y
{
    LineProcessView *p1 = [[LineProcessView alloc] initWithFrame:CGRectMake(20, y , CGRectGetWidth(self.view.frame) - 40, 20)];
    p1.processValue = process;
    p1.fillColor = [UIColor colorWithHexString:@"#6b5a53"]; //#859900
    p1.defaultColor = [UIColor colorWithHexString:@"#a4897e"];//2aa198
    [self.view addSubview:p1];
}
#pragma mark - Delegate
//代理方法


#pragma mark - Lazy Loads

@end
