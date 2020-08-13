//
//  CityModel+index.m
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "CityModel+index.h"

@implementation CityModel (index)
- (BOOL)sort:(CityModel *)model withModel:(CityModel *)model1
{
    NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSRange string1Range = NSMakeRange(0, [model.name length]);
    return [model.name compare:model1.name options:0 range:string1Range locale:locale];
}

@end
