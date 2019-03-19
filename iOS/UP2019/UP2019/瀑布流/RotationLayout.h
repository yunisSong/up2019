//
//  RotationLayout.h
//  UP2019
//
//  Created by Yunis on 2019/3/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 优化
 
 1. 设置旋转半径
 2. 设置item 大小
 3. 设置固定位置？？？设置一个选中区域，当item 未在范围区域内、或者没有位于区域中心，移动 item到区域中心。
 
 */

@interface RotationLayout : UICollectionViewLayout
/** 按钮半径 */
@property (assign, nonatomic) CGFloat itemRadius;

/** 按钮中心相对菜单中心旋转角度*/
@property (assign, nonatomic) CGFloat rotationAngle;

@end
