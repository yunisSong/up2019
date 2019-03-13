//
//  RotationLayout.h
//  UP2019
//
//  Created by Yunis on 2019/3/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotationLayout : UICollectionViewLayout
/** 按钮半径 */
@property (assign, nonatomic) CGFloat itemRadius;

/** 按钮中心相对菜单中心旋转角度*/
@property (assign, nonatomic) CGFloat rotationAngle;

@end
