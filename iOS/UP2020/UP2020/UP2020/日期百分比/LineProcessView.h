//
//  LineProcessView.h
//  UP2019
//
//  Created by Yunis on 2019/3/12.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]



@interface LineProcessView : UIView
@property (strong , nonatomic)UIColor * defaultColor;//背景颜色（默认值RGBA(216, 216, 216, 1)）

@property (strong , nonatomic)UIColor * fillColor;//进度颜色（默认值RGBA(33, 178, 123, 1)）

@property(assign , nonatomic)float processValue;//进度值
@end


