//
//  CityTableViewCell.m
//  UP2019
//
//  Created by Yunis on 2019/1/22.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configModel:(CityModel *)model
{
    self.leftCons.constant = model.level * 15;
    self.nameLabel.text = model.name;
//    self.nameLabel.font = [UIFont systemFontOfSize:28 - (model.level * 2)];
    if (!model.items) {
        self.endImageView.hidden = YES;
    }else
    {
        self.endImageView.hidden = NO;
    }
    if (model.isOpen) {
        self.endImageView.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
    }else
    {
        self.endImageView.transform = CGAffineTransformIdentity;
    }
}
@end
