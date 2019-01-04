//
//  Demo1TableViewCell.m
//  ScrollowDemo
//
//  Created by Yunis on 2018/12/29.
//  Copyright © 2018年 Yunis. All rights reserved.
//

#import "Demo1TableViewCell.h"

@implementation Demo1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view
{
    //获取当前 cell 在 view 的坐标 rect
    CGRect rect = [tableView convertRect:self.frame toView:view];
    //view 高度
    float height = view.bounds.size.height;
    //根据 rect 的y 值 计算出 image 的偏移量
    self.topLayout.constant = -(rect.origin.y) * (self.heightLayout.constant/height);
}
@end
