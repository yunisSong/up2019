//
//  SYCycleView.h
//  YunisDemo
//
//  Created by Yunis on 2020/10/20.
//  Copyright © 2020 Yunis. All rights reserved.
//

/*
 轮播图
 1. 传入图片 或者链接
 2. 设置样式
 3. 切换间隔时间
 
 
 
 1。 图片对应的文本标题
 2. 滚动的时间间隔
 3. 滚动方向
 4. 点击事件
 5。 滚动到指定的位置
 6. 分页图标的样式 颜色 形状 大小
 7 标题文字的样式、
 8 自动滚动 无限循环
 9 文字阴影是否显示

 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SYPageControlStyle) {
	SYPageControlStyle_Left,
	SYPageControlStyle_Right,
	SYPageControlStyle_Center,
};
@interface SYCycleStyle:NSObject
//时间间隔
@property(nonatomic,assign)float ScrollTimeInterval;
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,assign)BOOL showShadow;
@property(nonatomic,assign)BOOL autoScroll;
@property(nonatomic,assign)BOOL scrollLoop;
@property(nonatomic,assign)BOOL showPageControl;
@property(nonatomic,assign)SYPageControlStyle pageStyle;

@end

@interface SYCycleView : UIView

+ (instancetype)showWithImageURLs:(NSArray <NSString *>*)imageURLs style:(SYCycleStyle *)style;
+ (instancetype)showWithImages:(NSArray <UIImage *>*)images style:(SYCycleStyle *)style;

@end
