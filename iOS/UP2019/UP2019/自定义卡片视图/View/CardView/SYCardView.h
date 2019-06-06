//
//  SYCardView.h
//  UP2019
//
//  Created by Yunis on 2019/2/15.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCardViewCell.h"
@class SYCardView;

@protocol SYCardViewDataSource <NSObject>

- (NSInteger)numberOfCountInSYCardView:(SYCardView *)cardView;
- (SYCardViewCell *)cardView:(SYCardView *)cardView cellForRowAtIndex:(NSInteger *)index;

@end


@protocol SYCardViewDelegate <NSObject>

@end


@interface SYCardView : UIView
@property (nonatomic, weak) id<SYCardViewDataSource> dataSource; /**<数据源*/

@end
