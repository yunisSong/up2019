//
//  LayoutDemo1.h
//  UP2019
//
//  Created by Yunis on 2019/3/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 
 抄袭自：
 https://github.com/saitjr/WaterFlowLayoutDemo
 
 */
@class LayoutDemo1;

@protocol CustomCollectionViewLayoutDelegate <NSObject>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(LayoutDemo1 *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface LayoutDemo1 : UICollectionViewLayout

@property (assign, nonatomic) id<CustomCollectionViewLayoutDelegate> layoutDelegate;

@end
