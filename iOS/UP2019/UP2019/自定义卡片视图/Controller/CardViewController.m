//
//  CardViewController.m
//  UP2019
//
//  Created by Yunis on 2019/2/14.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()

@end

@implementation CardViewController

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
