//
//  RTFViewController.m
//  UP2019
//
//  Created by Yunis on 2019/3/21.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "RTFViewController.h"

#import <SYTouchLabel.h>
@interface RTFViewController ()

@end

@implementation RTFViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadSubViews {
    SYTouchLabel *label = [[SYTouchLabel alloc] init];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    label.text = @"是的阿萨德法师是的阿萨德法师是的建设eeeeeeeeeeeeeeeeeeeeeeeeee社会主义新中国萨德法师是的阿萨德法师是的阿萨德法师是的阿萨德法师是的阿萨德法师";
    label.sy_clickString = @"eeeeeeeeeeeeeeeeeeeeeeeeee";
    label.sy_clickRange = NSMakeRange(2, 5 );
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).offset(- 40);
    }];
    
    label.clickBlock = ^(NSString *clickString)
    {
        NSLog(@"点击的文本为 %@",clickString);
    };
}



#pragma mark - Target Methods
//点击事件

#pragma mark - Network Methods
//网络请求

#pragma mark - Public Method
//外部方法

#pragma mark - Private Method
//私有方法

#pragma mark - Delegate
//代理方法


#pragma mark - Lazy Loads

@end
