//
//  UIColor+Extension.h
//  Template
//
//  Created by fulin on 15/8/14.
//  Copyright (c) 2015年 fulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  根据RGB生成UIColor
 *
 *  @param rValue Red十进制颜色值
 *  @param gValue Green十进制颜色值
 *  @param bValue Blue十进制颜色值
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithR:(CGFloat)rValue G:(CGFloat)gValue B:(CGFloat)bValue;

/**
 *  颜色转换 IOS中十六进制的颜色转换为UIColor
 *
 *  @param color 16进制字符串
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;


@end
