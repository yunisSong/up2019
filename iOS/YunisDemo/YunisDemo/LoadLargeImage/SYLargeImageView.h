//
//  SYLargeImageView.h
//  YunisDemo
//
//  Created by Yunis on 2020/8/13.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYLargeImageView : UIView

- (void)loadWithImageURL:(NSString *)imageURL;
- (void)loadWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
