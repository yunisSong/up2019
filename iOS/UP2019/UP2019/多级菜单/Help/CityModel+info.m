//
//  CityModel+info.m
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "CityModel+info.h"
#import <objc/runtime.h>
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
- (NSArray *)iteration:(NSDictionary *)provinceDic parentLevel:(NSInteger)level parentModel:(CityModel *)pmodel
{
    NSMutableArray *a = [NSMutableArray new];
    
    [provinceDic.allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = provinceDic[key];
        CityModel *model = [CityModel new];
        model.code  = key;
        model.name = name;
        model.level = level + 1;
//        if (pmodel.isOpen) {
//            [self.displayArray addObject:model];
//        }
        if ([self allInfo][key] )
        {
            NSArray *items = [self iteration:[self allInfo][key] parentLevel:model.level parentModel:model];
            NSArray *result = [items sortedArrayUsingComparator:^NSComparisonResult(CityModel *obj1, CityModel *obj2) {
                NSString *hanziText1 = obj1.name;
                NSMutableString *ms1;
                NSMutableString *ms2;
                if ([hanziText1 length]) {
                    ms1 = [[NSMutableString alloc] initWithString:hanziText1];
                    if (CFStringTransform((__bridge CFMutableStringRef)ms1, 0, kCFStringTransformMandarinLatin, NO)) {
                    }
                }
                
                NSString *hanziText2 = obj2.name;
                if ([hanziText2 length]) {
                    ms2 = [[NSMutableString alloc] initWithString:hanziText2];
                    if (CFStringTransform((__bridge CFMutableStringRef)ms2, 0, kCFStringTransformMandarinLatin, NO)) {
                    }
                }
                return [ms1 compare:ms2]; //升序
            }];
            model.items = result;
        }
        [a addObject:model];
    }];
    NSArray *b = [a sortedArrayUsingComparator:^NSComparisonResult(CityModel *obj1, CityModel *obj2) {
        NSString *hanziText1 = obj1.name;
        NSMutableString *ms1;
        NSMutableString *ms2;
        if ([hanziText1 length]) {
            ms1 = [[NSMutableString alloc] initWithString:hanziText1];
            if (CFStringTransform((__bridge CFMutableStringRef)ms1, 0, kCFStringTransformMandarinLatin, NO)) {
            }
        }
        
        NSString *hanziText2 = obj2.name;
        if ([hanziText2 length]) {
            ms2 = [[NSMutableString alloc] initWithString:hanziText2];
            if (CFStringTransform((__bridge CFMutableStringRef)ms2, 0, kCFStringTransformMandarinLatin, NO)) {
            }
        }
        return [ms1 compare:ms2]; //升序
    }];
    return b;
}


//- (NSMutableArray *)displayArray
//{
//    NSMutableArray *array = objc_getAssociatedObject(self, DropListViewHelpKey);
//    if (!array)
//    {
//        array    = [NSMutableArray new];
//        objc_setAssociatedObject(self, DropListViewHelpKey, array, OBJC_ASSOCIATION_RETAIN);
//    }
//    return array;
//}
//
//- (void)setDisplayArray:(UITableView *)displayArray
//{
//    objc_setAssociatedObject(self, DropListViewHelpKey, displayArray, OBJC_ASSOCIATION_RETAIN);
//}

@end
