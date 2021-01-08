//
//  UIView+SYLayoutHelp.h
//  YunisDemo
//
//  Created by Yunis on 2020/9/17.
//  Copyright © 2020 Yunis. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UIView (SYLayoutHelp)
- (void)st_addSubview:(UIView *)subView mas_makeConstraints:(void(^)(MASConstraintMaker *))block;
@end

