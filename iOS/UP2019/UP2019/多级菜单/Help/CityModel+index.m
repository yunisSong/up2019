//
//  CityModel+index.m
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "CityModel+index.h"

@implementation CityModel (index)
/*
 新建一个数组记录当前已经展示的数据，Tableview 从这个数组里面拿数据。
 array insetarray
 变成一维的数组
 */
- (int)count
{
    __block int count = 0;
    [self.items enumerateObjectsUsingBlock:^(BaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int sCount = [self countIndex:obj];
        count += sCount;
    }];
    
    return count;
}
- (CityModel *)modelWithIndex:(NSInteger)index
{
    
    return nil;
}
- (int )countIndex:(CityModel *)model {
    if (model.isOpen)
    {
        return model.items.count;
    }else
    {
        return 1;
    }
}
@end
