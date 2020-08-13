//
//  ImageCollectionViewCell.m
//  YXHeFei
//
//  Created by 张鹏 on 2018/8/7.
//  Copyright © 2018年 天源迪科. All rights reserved.
//

#import "ImageCollectionViewCell.h"
//#import <SDWebImage.h>

//#import "UIImage+EXtension.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
    //Yunis
    UIImage *image = dataDict[@"image"];
    if (image) {
        _img.image = image;
    }else
    {
//        [_img sd_setImageWithURL:[dataDict[@"imageURL"] urlValue] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//               if (image) {
//                   image.urlKey = dataDict[@"imageURL"];
//               }
//           }];
    }
   if (![dataDict[@"index"] isEqualToString:@"99"]) {
       WS(weakSelf);
       [self.img showDeleteIconHandel:^{
           if (weakSelf.handel) {
               weakSelf.handel();
           }
       }];
    }else
    {
        [self.img hiddenDeleteIcon];
    }
}
-(void)setImagUrl:(NSString *)imagUrl
{
    _imagUrl = imagUrl;
    
    if ([imagUrl hasPrefix:@"http://"] || [imagUrl hasPrefix:@"https://"]) {
        [_img  sd_setImageWithURL:[imagUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] placeholderImage:nil];
    }else{
//        _img.image = [UIImage imageWithColor:KColor(244, 244, 244)];
    }
}
@end
