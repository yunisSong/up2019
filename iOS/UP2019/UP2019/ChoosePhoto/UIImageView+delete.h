//
//  UIImageView+delete.h
//  YXHeFei
//
//  Created by 宋尚永 on 2019/11/16.
//  Copyright © 2019 天源迪科. All rights reserved.
//



#import <UIKit/UIKit.h>
typedef void (^deleteHandel) ();
@interface UIImageView (delete)
@property (strong, nonatomic) UIImageView *sy_deleteImageIcon;
- (void)showDeleteIconHandel:(deleteHandel)handel;
- (void)hiddenDeleteIcon;
@end

