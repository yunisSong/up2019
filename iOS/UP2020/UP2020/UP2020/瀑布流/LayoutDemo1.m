//
//  LayoutDemo1.m
//  UP2019
//
//  Created by Yunis on 2019/3/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "LayoutDemo1.h"
@interface LayoutDemo1()
@property(nonatomic,assign)float leftY;
@property(nonatomic,assign)float rightY;
@property (assign, nonatomic) NSInteger cellCount; // cell个数
@property (assign, nonatomic) CGFloat itemWidth; // cell宽度
@property (assign, nonatomic) CGFloat insert; // 间距

@end

@implementation LayoutDemo1
/**
 *  初始化layout后自动调动，可以在该方法中初始化一些自定义的变量参数
 */
- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    self.insert = 10;
    self.itemWidth = (SCREEN_WIDTH - 3 * self.insert) / 2;

}

/**
 *  设置UICollectionView的内容大小，道理与UIScrollView的contentSize类似
 *
 *  @return 返回设置的UICollectionView的内容大小
 */
- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(SCREEN_WIDTH, MAX(_leftY, _rightY));
}

/**
 *  初始Layout外观
 *
 *  @param rect 所有元素的布局属性
 *
 *  @return 所有元素的布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    self.leftY = self.insert;
    self.rightY = self.insert;
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
    CGSize itemSize = [self.layoutDelegate collectionView:self.collectionView collectionViewLayout:self sizeOfItemAtIndexPath:indexPath];
    // 防止代理中给的size.width大于(或小于)layout中定义的width，所以等比例缩放size
    CGFloat itemHeight = floorf(itemSize.height * self.itemWidth / itemSize.width);
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 判断当前的item应该在左侧还是右侧
    BOOL isLeft = _leftY < _rightY;

    if (isLeft) {

        CGFloat x = _insert; // x轴起始位置为0
        attributes.frame = CGRectMake(x, _leftY, _itemWidth, itemHeight);
        _leftY += itemHeight + _insert; // 设置新的Y起点
    }

    if (!isLeft) {

        CGFloat x = _itemWidth + 2 * _insert;
        attributes.frame = CGRectMake(x, _rightY, _itemWidth, itemHeight);
        _rightY += itemHeight + _insert;
    }

    return attributes;
}
@end
