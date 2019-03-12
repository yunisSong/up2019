//
//  UIColor+Extension.m
//  Template
//
//  Created by fulin on 15/8/14.
//  Copyright (c) 2015年 fulin. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

/**
 *  根据RGB生成UIColor
 *
 *  @param rValue Red十进制颜色值
 *  @param gValue Green十进制颜色值
 *  @param bValue Blue十进制颜色值
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithR:(CGFloat)rValue G:(CGFloat)gValue B:(CGFloat)bValue
{
    return [UIColor colorWithRed:((float)rValue/255.0f) green:((float)gValue/255.0f) blue:((float)bValue/255.0f) alpha:1];
}

/**
 *  颜色转换 IOS中十六进制的颜色转换为UIColor
 *
 *  @param color 16进制字符串
 *
 *  @return UIColor
 */
+ (UIColor *) colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


@end
