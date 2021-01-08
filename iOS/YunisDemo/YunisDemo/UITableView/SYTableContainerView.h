//
//  SYTableContainerView.h
//  YunisDemo
//
//  Created by Yunis on 2020/10/29.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 下拉刷新、上拉加载更多
 记录当前页码
 点击事件回调
 注册 cell 的方法 多个 样式
 
 */
@class SYTableContainerView;

typedef SYTableContainerView * (^beginHeadRefreshBlock)(dispatch_block_t handle);
typedef SYTableContainerView * (^beginFootRefreshBlock)(dispatch_block_t handle);

typedef void (^TableViewCellConfigureBlock)(id cell, NSIndexPath * indexPath);
typedef void (^didSelectCellBlock) (NSIndexPath * indexPath);
typedef NSInteger (^sectionIndex) (NSInteger sectionIndex);

typedef SYTableContainerView * (^configureCell) (TableViewCellConfigureBlock);
typedef SYTableContainerView * (^didSelectCell) (didSelectCellBlock);
typedef SYTableContainerView * (^configureSource) (NSArray *items);
typedef SYTableContainerView * (^cellIdentifier) (NSString *aCellIdentifier);
typedef SYTableContainerView * (^emptyTitle) (NSString *empty);
typedef SYTableContainerView * (^numberOfSections)(NSInteger sections);
typedef SYTableContainerView * (^numberOfRows)(sectionIndex);
typedef SYTableContainerView * (^reloadData)(void);

@interface SYTableContainerView : UIView

@property(nonatomic,assign)int currentPageIndex; /**<当前显示数据页码 默认为 0 */

//下拉刷新回调
- (beginHeadRefreshBlock)refreshHandle;
- (beginFootRefreshBlock)refreshFootHandle;

- (void)beginHeadRefresh;
- (void)endHeadRefresh;

- (void)beginFootRefresh;
- (void)endFootRefresh;



@end
