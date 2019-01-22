//
//  MBProgressHUD+show.h
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "MBProgressHUD.h"
#import <MBProgressHUD.h>
@interface MBProgressHUD (show)
+ (MBProgressHUD *)showLoadingWithMessage:(NSString *)message toView:(UIView *)view;
@end
