//
//  NSDate+index.m
//  UP2019
//
//  Created by Yunis on 2019/3/12.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "NSDate+index.h"

@implementation NSDate (index)

+(NSString *)getCurrentTimesWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}
+ (NSString *)year
{
    return [NSDate getCurrentTimesWithFormat:@"YYYY"];
}
+ (NSString *)month
{
    return [NSDate getCurrentTimesWithFormat:@"MM"];
}
+ (NSString *)day
{
    return [NSDate getCurrentTimesWithFormat:@"dd"];
}

+ (int)daysOfYeay
{
    int year = [[NSDate year] intValue];
    int days[12] = { 31, 30, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    //判断二月有多少天
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
    {
        days[1] = 29;
    }
    else
    {
        days[1] = 28;
    }
    int out=0;
    for (int i = 1; i < 12;i++)
    {
        out += days[i-1];
    }
    return out;
}
+ (int)daysOfMonth
{
    int year = [[NSDate year] intValue];
    int month = [[NSDate month] intValue];
    int days[12] = { 31, 30, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    //判断二月有多少天
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
    {
        days[1] = 29;
    }
    else
    {
        days[1] = 28;
    }
    return days[month - 1];
}

+ (NSString*)weekdayString {
    NSDate *inputDate = [NSDate date];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"7", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (int)indexOfWeek
{
    NSString *week = [NSDate weekdayString];
    return [week intValue];
}
+ (int)indexOfMonth
{
    int days = [[NSDate day] intValue];
    return days;
}
+ (int)indexOfYear
{
    int year = [[NSDate year] intValue];
    int month = [[NSDate month] intValue];
    int day = [[NSDate day] intValue];
    int days[12] = { 31, 30, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    //判断二月有多少天
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
    {
        days[1] = 29;
    }
    else
    {
        days[1] = 28;
    }
    int out=0;
    for (int i = 1; i < month;i++)
    {
        out += days[i-1];
    }
    
    return out + day;
}

+ (int)lastOfYear
{
    int year = [NSDate daysOfYeay];
    int index = [NSDate indexOfYear];

    NSLog(@" %d  %d",year,index);
    return year - index;
}
+ (float)percentOfWeek
{
    int week = [NSDate indexOfWeek];
    return week/7.f;
}
+ (float)percentOfMonth
{
    float indexDay = [NSDate indexOfMonth];
    float days = [NSDate daysOfMonth];
    return indexDay/days;
}
+ (float)percentOfYear
{
    float indexDay = [NSDate indexOfYear];
    float days = [NSDate daysOfYeay];
    
    return indexDay/days;
}
@end
