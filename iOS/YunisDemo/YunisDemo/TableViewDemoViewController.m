//
//  TableViewDemoViewController.m
//  YunisDemo
//
//  Created by Yunis on 2020/10/29.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "TableViewDemoViewController.h"
#import "SYTableContainerView.h"

@interface TableViewDemoViewController ()

@end

@implementation TableViewDemoViewController


#pragma mark - Public Method
//外部方法

#pragma mark - Life Cycle
//系统方法
- (void)viewDidLoad {
	[super viewDidLoad];
	//加载页面
	[self assignDate];
	[self settingAppearance];
	[self loadSubViews];
	
	/*
	 [SYTableContainerView tableview]
	 recell
	 indexOfcell
	 ref
	 pull
	 pageIndx
	 */
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//布局
	NSLog(@"111111111");

	SYTableContainerView *tableView = [SYTableContainerView new];;
//	[tableView beginHeadRefresh];
	[tableView refreshHandle](^{
		NSLog(@"pppppppppppppp");
	});
//	tableView.refreshHandle(^{
//		NSLog(@"22222222");
//
//	});

}
#pragma mark - Intial Methods
//初始化数据
- (void)assignDate {
	
}

- (void)settingAppearance {
	
}

- (void)loadSubViews {
	
}

#pragma mark - Network Methods && Target Methods
//网络请求 && 点击事件

#pragma mark - Private Method
//私有方法

#pragma mark - Delegate
//代理方法


#pragma mark - Lazy Loads


@end
