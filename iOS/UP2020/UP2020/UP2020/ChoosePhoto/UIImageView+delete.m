//
//  UIImageView+delete.m
//  YXHeFei
//
//  Created by 宋尚永 on 2019/11/16.
//  Copyright © 2019 天源迪科. All rights reserved.
//

#import "UIImageView+delete.h"
#import <objc/runtime.h>
@implementation UIImageView (delete)

static char *sy_deleteImageIconKey;
static char *sy_handelKey;

static const char *UIButton_acceptEventInterval = "UIButton_acceptEventInterval";
static const char *UIButton_acceptEventTime     = "UIButton_acceptEventTime";

- (NSTimeInterval )mm_acceptEventInterval{
    return 1.f;
    return [objc_getAssociatedObject(self, UIButton_acceptEventInterval) doubleValue];
}

- (void)setMm_acceptEventInterval:(NSTimeInterval)mm_acceptEventInterval{
    objc_setAssociatedObject(self, UIButton_acceptEventInterval, @(mm_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )mm_acceptEventTime{
    return [objc_getAssociatedObject(self, UIButton_acceptEventTime) doubleValue];
}

- (void)setMm_acceptEventTime:(NSTimeInterval)mm_acceptEventTime{
    objc_setAssociatedObject(self, UIButton_acceptEventTime, @(mm_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hiddenDeleteIcon
{
    self.sy_deleteImageIcon.hidden = YES;
    [self.sy_deleteImageIcon removeFromSuperview];
    
}
- (void)showDeleteIconHandel:(deleteHandel)handel
{
    self.userInteractionEnabled = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_delete"]];
        imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMessage)];
    [imageView addGestureRecognizer:tap];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.right.equalTo(self);
    }];
    
    self.sy_deleteImageIcon = imageView;
    [self setSy_handel:handel];
}

- (void)clickMessage
{
    if (NSDate.date.timeIntervalSince1970 - self.mm_acceptEventTime < self.mm_acceptEventInterval) {
         return;
     }
     
     if (self.mm_acceptEventInterval > 0) {
         self.mm_acceptEventTime = NSDate.date.timeIntervalSince1970;
     }
    if ([self sy_handel]) {
        [self sy_handel]();
    }
}

- (void)setSy_deleteImageIcon:(UIImageView *)sy_deleteImageIcon {
    
    objc_setAssociatedObject(self, &sy_deleteImageIconKey, sy_deleteImageIcon, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)sy_deleteImageIcon {
    UIImageView *iamgeView = objc_getAssociatedObject(self, &sy_deleteImageIconKey);
    return iamgeView;
}


- (void)setSy_handel:(dispatch_block_t )sy_handel {
    
    objc_setAssociatedObject(self, &sy_handelKey, sy_handel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_block_t)sy_handel {
    dispatch_block_t handel = objc_getAssociatedObject(self, &sy_handelKey);
    return handel;
}
@end
