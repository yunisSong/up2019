//
//  CityModel+info.m
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "CityModel+info.h"
#import <objc/runtime.h>
#import "CityModel+index.h"
static const void *DropListViewHelpKey = &DropListViewHelpKey;

@implementation CityModel (info)
+ (CityModel *)allCity {
    CityModel *m = [CityModel new];
    NSDictionary *provinceDic = [m allInfo][@"86"];
    NSArray *t = [m iteration:provinceDic parentLevel:0 parentModel:m];
    m.code = @"86";
    m.name = @"中国";
    m.items = t;
    m.level = 0;
    m.open = YES;
    return m;
}
- (NSDictionary *)allInfo {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSError *err;
    NSDictionary *allDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err];
    return allDic;
}

/**
 组织数据

 @param provinceDic 子节点数据
 @param level 数据层级
 @param pmodel 子节点的父节点
 @return 子节点数组
 */
- (NSArray *)iteration:(NSDictionary *)provinceDic parentLevel:(NSInteger)level parentModel:(CityModel *)pmodel
{
    NSMutableArray *a = [NSMutableArray new];
    [provinceDic.allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = provinceDic[key];
        CityModel *model = [CityModel new];
        model.code  = key;
        model.name = name;
        model.level = level + 1;
        if ([self allInfo][key] )
        {
            NSArray *items = [self iteration:[self allInfo][key] parentLevel:model.level parentModel:model];
            NSArray *result = [items sortedArrayUsingComparator:^NSComparisonResult(CityModel *obj1, CityModel *obj2) {
                //排序。把这几行代码提出公共方法出来就不生效了！！
                NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
                NSRange string1Range = NSMakeRange(0, [obj1.name length]);
                return [obj1.name compare:obj2.name options:0 range:string1Range locale:locale];
            }];
            model.items = result;
        }
        [a addObject:model];
    }];
    NSArray *b = [a sortedArrayUsingComparator:^NSComparisonResult(CityModel *obj1, CityModel *obj2) {
        NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSRange string1Range = NSMakeRange(0, [obj1.name length]);
        return [obj1.name compare:obj2.name options:0 range:string1Range locale:locale];
    }];
    return b;
}


@end
