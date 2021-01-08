//
//  UIView+SYLayoutHelp.m
//  YunisDemo
//
//  Created by Yunis on 2020/9/17.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "UIView+SYLayoutHelp.h"
@implementation UIView (SYLayoutHelp)
- (void)st_addSubview:(UIView *)subView mas_makeConstraints:(void(^)(MASConstraintMaker *make))block{
	[self addSubview:subView];
	[subView mas_makeConstraints:block];
}
@end
