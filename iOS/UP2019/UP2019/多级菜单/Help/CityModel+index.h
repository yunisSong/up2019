//
//  CityModel+index.h
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "CityModel.h"

@interface CityModel (index)
- (int)count ;
- (CityModel *)modelWithIndex:(NSInteger)index;
@end
