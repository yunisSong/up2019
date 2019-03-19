//
//  RotationLayout.m
//  UP2019
//
//  Created by Yunis on 2019/3/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "RotationLayout.h"
@interface RotationLayout()
@property(nonatomic,assign)float leftY;
@property(nonatomic,assign)float rightY;
@property (assign, nonatomic) NSInteger cellCount; // cell个数

@end
@implementation RotationLayout
- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    
}

/**
 *  设置UICollectionView的内容大小，道理与UIScrollView的contentSize类似
 *
 *  @return 返回设置的UICollectionView的内容大小
 */
- (CGSize)collectionViewContentSize {

    return self.collectionView.frame.size;;
}

/**
 *  初始Layout外观
 *
 *  @param rect 所有元素的布局属性
 *
 *  @return 所有元素的布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < self.cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

/**
 *  根据不同的indexPath，给出布局
 *
 *  @param indexPath d
 *
 *  @return 布局
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取代理中返回的每一个cell的大小
    CGSize itemSize = CGSizeMake(75, 75);
    // 防止代理中给的size.width大于(或小于)layout中定义的width，所以等比例缩放size
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    // 先设定大圆的半径 取长和宽最短的
    CGFloat radius = MIN(self.collectionView.frame.size.width, self.collectionView.frame.size.height) / 2.2;
    // 圆心位置
    CGPoint center = CGPointMake(self.collectionView.frame.size.width / 2.0, self.collectionView.frame.size.height / 2.0);

    float x = center.x + cosf(2 * M_PI / self.cellCount * indexPath.row + _rotationAngle) * (radius - itemSize.width / 2.0);
    float y = center.y + sinf(2 * M_PI / self.cellCount * indexPath.row + _rotationAngle) * (radius - itemSize.width / 2.0);
    
    attributes.frame = CGRectMake(x, y, itemSize.width, itemSize.height);
    attributes.center = CGPointMake(x, y);
    return attributes;
}
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}
//- (void)setRotationAngle:(CGFloat)rotationAngle
//{
//    _rotationAngle = rotationAngle;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        // something
//        [self invalidateLayout];
//
//    });
//}
@end
