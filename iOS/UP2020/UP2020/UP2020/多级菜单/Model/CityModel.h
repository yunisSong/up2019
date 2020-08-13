//
//  CityModel.h
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "BaseModel.h"

@interface CityModel : BaseModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger level;
@end
