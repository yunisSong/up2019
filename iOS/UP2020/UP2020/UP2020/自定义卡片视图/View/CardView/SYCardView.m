//
//  SYCardView.m
//  UP2019
//
//  Created by Yunis on 2019/2/15.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "SYCardView.h"
@interface SYCardView()

@property(nonatomic,strong)UIView *containerView;

@end
@implementation SYCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /*
         边距
         圆角
         阴影
         显示个数
         如何分布
         
         每个视图的间隔
         
         拖拽动画 使用截图大法，开始拖拽，加载一个动画在 window 上，隐藏 cell。
         
         
         底部间距/显示的个数 + 1
         缓存显示的数据。
         -- helpView add cellView
         
         */
    }
    return self;
}
@end
