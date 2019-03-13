//
//  NSDate+index.h
//  UP2019
//
//  Created by Yunis on 2019/3/12.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (index)

+ (NSString *)year;
+ (NSString *)month;
+ (NSString *)day;


+ (int)indexOfWeek;
+ (int)indexOfMonth;
+ (int)indexOfYear;

+ (int)lastOfYear;

+ (float)percentOfWeek;
+ (float)percentOfMonth;
+ (float)percentOfYear;


+ (NSString*)weekdayString;

@end

