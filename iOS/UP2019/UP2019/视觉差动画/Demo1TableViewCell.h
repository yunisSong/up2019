//
//  Demo1TableViewCell.h
//  ScrollowDemo
//
//  Created by Yunis on 2018/12/29.
//  Copyright © 2018年 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Demo1TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;
@property (weak, nonatomic) IBOutlet UIImageView *ss_imageView;
- (void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view;
@end
