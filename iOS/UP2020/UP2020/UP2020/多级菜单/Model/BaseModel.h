//
//  BaseModel.h
//  UP2019
//
//  Created by Yunis on 2019/1/17.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property(class,nonatomic,strong)NSMutableArray *displayArray;
@property(class,nonatomic,assign)NSInteger reloadCount;

@property(nonatomic,strong)NSArray <BaseModel *>*items;
@property(nonatomic,assign,getter=isOpen)BOOL open;

@end
