//
//  SYTableContainerView.m
//  YunisDemo
//
//  Created by Yunis on 2020/10/29.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "SYTableContainerView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface SYTableContainerView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)dispatch_block_t refHandel;
@property(nonatomic,copy)dispatch_block_t refFootHandel;

@end
@implementation SYTableContainerView


#pragma mark - Public Method
//外部方法
- (beginHeadRefreshBlock)refreshHandle
{
	WS(weakSelf);
    return ^(dispatch_block_t back){
        weakSelf.refHandel = back;
        return weakSelf;
    };
}
- (beginFootRefreshBlock)refreshFootHandle
{
	WS(weakSelf);
    return ^(dispatch_block_t back){
        weakSelf.refFootHandel = back;
        return weakSelf;
    };
}
#pragma mark - Life Cycle
//系统方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		//加载页面
		[self assignDate];
		[self settingAppearance];
		[self loadSubViews];
	}
	return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self assignDate];
		[self settingAppearance];
		[self loadSubViews];
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			if (self.refHandel) {
				self.refHandel();
			}
		});
	}
	return self;
}
- (void)dealloc
{
    NSLog(@"SYTableContainerView dealloc");
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
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSInteger count = self.sectionIndex(section);
//    if (self.emptyViewTitle)
//    {
////        [tableView tableViewDisplayEmptyViewWithTitle:self.emptyViewTitle
////                               ifNecessaryForRowCount:count];
//    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
//                                                            forIndexPath:indexPath];
//	__weak __typeof(&*cell)weakCell = cell;
//	__weak __typeof(&*indexPath)weakIndexPath = indexPath;
//
//    self.configureCellBlock(weakCell, weakIndexPath);
//    return cell;
}

#pragma mark - Lazy Loads

@end
