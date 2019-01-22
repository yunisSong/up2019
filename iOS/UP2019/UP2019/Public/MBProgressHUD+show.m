//
//  MBProgressHUD+show.m
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "MBProgressHUD+show.h"

@implementation MBProgressHUD (show)

+ (MBProgressHUD *)showLoadingWithMessage:(NSString *)message toView:(UIView *)view {
    //显示在父View
    if ( view == nil )
    {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // MBProgressHUD颜色
    hud.color = [UIColor darkGrayColor];
    // 显示文本
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}
@end
