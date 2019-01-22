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
            [self delSubList:self.items withParentObj:self];
        }
    }
}
- (void)addSubList:(NSArray <BaseModel *>*)subArray withParentObj:(BaseModel *)parentModel{
    NSInteger index = 0;
    if ([BaseModel.displayArray containsObject:parentModel]) {
        index = [BaseModel.displayArray indexOfObject:parentModel];
    }
    NSMutableArray *temp = [NSMutableArray new];
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
- (int)addSubList1:(NSArray <BaseModel *>*)subArray withParentObj:(BaseModel *)parentModel{
    NSInteger index = 0;
    if ([BaseModel.displayArray containsObject:parentModel]) {
        index = [BaseModel.displayArray indexOfObject:parentModel];
    }
    NSMutableArray *temp = [NSMutableArray new];
    __block int count = 0;
    [subArray enumerateObjectsUsingBlock:^(BaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index + 1 >=  BaseModel.displayArray.count)
        {
            [BaseModel.displayArray addObject:obj];
        }else
        {
            [BaseModel.displayArray insertObject:obj atIndex:index + 1];
        }
        count += 1;
        if (obj.isOpen) {
            int scount = [self addSubList1:obj.items withParentObj:obj];
            count += scount;

        }
    }];
    return count;
}
- (void)delSubList:(NSArray <BaseModel *>*)subArray withParentObj:(BaseModel *)parentModel{
//    NSInteger index = 0;
//    if ([BaseModel.displayArray containsObject:parentModel])
//    {
//        index = [BaseModel.displayArray indexOfObject:parentModel];
//    }
    [subArray enumerateObjectsUsingBlock:^(BaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self delSubList:obj.items withParentObj:obj];
        [BaseModel.displayArray removeObject:obj];
    }];
    
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
