//
//  BaseModel.m
//  UP2019
//
//  Created by Yunis on 2019/1/17.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "BaseModel.h"
@interface BaseModel()

@end
@implementation BaseModel
- (void)setOpen:(BOOL)open
{
    _open = open;
    NSInteger index = 0;
    if ([BaseModel.displayArray containsObject:self]) {
        index = [BaseModel.displayArray indexOfObject:self];
    }
    NSLog(@"index == %ld",(long)index);
    if (_open)
    {
        NSLog(@"++++++++++++++++++++++++++++++++");
        //子节点加入到要显示的数组里面。
        if (self.items)
        {
            BaseModel.reloadCount =  [self addSubList1:self.items withParentObj:self];
        }
    }else
    {
        NSLog(@"--------------------------------");

        if (self.items)
        {
            BaseModel.reloadCount = [self delSubList:self.items withParentObj:self];
        }
    }
}
- (void)addSubList:(NSArray <BaseModel *>*)subArray withParentObj:(BaseModel *)parentModel{
    NSInteger index = 0;
    if ([BaseModel.displayArray containsObject:parentModel]) {
        index = [BaseModel.displayArray indexOfObject:parentModel];
    }
    [subArray enumerateObjectsUsingBlock:^(BaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index + 1 >=  BaseModel.displayArray.count) {
            [BaseModel.displayArray addObject:obj];

        }else
        {
            [BaseModel.displayArray insertObject:obj atIndex:index + 1];
        }
        if (obj.isOpen) {
            [self addSubList:obj.items withParentObj:obj];
        }
    }];
}

/**
 把要显示的数据加入到 displayArray 数组中

 @param subArray 要加入到 displayArray 的数据源
 @param parentModel 父节点
 @return 本次添加到 displayArray 的个数，为了刷新tableView 准备数据。
 */
- (int)addSubList1:(NSArray <BaseModel *>*)subArray withParentObj:(BaseModel *)parentModel{
    __block NSInteger index = 0;
    if ([BaseModel.displayArray containsObject:parentModel]) {
        index = [BaseModel.displayArray indexOfObject:parentModel];
    }
    __block int count = 0;
    [subArray enumerateObjectsUsingBlock:^(BaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index + 1 >=  BaseModel.displayArray.count)
        {
            [BaseModel.displayArray addObject:obj];
            
        }else
        {
            [BaseModel.displayArray insertObject:obj atIndex:index + 1];
        }
        index += 1;
        count += 1;
        if (obj.isOpen) {
            int scount = [self addSubList1:obj.items withParentObj:obj];
            count += scount;
        }
    }];
    return count;
}

/**
 把不显示的数据移除 displayArray 数组中


 @param subArray 要移除的数据源
 @param parentModel 父节点
 @return 本次移除 displayArray 的个数，为了刷新tableView 准备数据。
 */
- (int)delSubList:(NSArray <BaseModel *>*)subArray withParentObj:(BaseModel *)parentModel{
    __block int count = 0;

    [subArray enumerateObjectsUsingBlock:^(BaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count += 1;
        if (obj.open) {
            int scount = [self delSubList:obj.items withParentObj:obj];
            count += scount;
        }
        [BaseModel.displayArray removeObject:obj];
    }];
    
    return count;
}


- (BaseModel *)objectAtIndex:(NSInteger)index {
    if (index <= BaseModel.displayArray.count) {
        return BaseModel.displayArray[index];
    }
    return nil;
}

static NSMutableArray *_displayArray = nil;
+ (NSMutableArray*)displayArray {
    if (!_displayArray) {
        _displayArray = [NSMutableArray new];
        BaseModel.displayArray = _displayArray;
    }
    return _displayArray;
}
+ (void)setDisplayArray:(NSMutableArray *)displayArray {
    if (displayArray) {
        _displayArray = displayArray;
    }
}

static NSUInteger _reloadCount = 0;
+ (NSInteger )reloadCount {
    return _reloadCount;
}
+ (void)setReloadCount:(NSInteger)reloadCount {
    _reloadCount = reloadCount;
}
@end
