//
//  ImageCollectionViewCell.h
//  YXHeFei
//
//  Created by 张鹏 on 2018/8/7.
//  Copyright © 2018年 天源迪科. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+delete.h"
@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property(nonatomic,strong) dispatch_block_t handel;
@property (nonatomic,strong) NSDictionary * dataDict;

@property (nonatomic,strong) NSString * imagUrl;

@end
