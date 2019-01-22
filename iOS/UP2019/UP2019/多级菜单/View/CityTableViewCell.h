//
//  CityTableViewCell.h
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel+info.h"

@interface CityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) IBOutlet UIImageView *endImageView;

- (void)configModel:(CityModel *)model;
@end
