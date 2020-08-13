//
//  LayoutDemoViewController.m
//  UP2019
//
//  Created by Yunis on 2019/3/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "LayoutDemoViewController.h"
#import "LayoutDemo1.h"
#import "RotationLayout.h"
@interface LayoutDemoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CustomCollectionViewLayoutDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) RotationLayout *rotationLayout;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *itemHeights;


@property (nonatomic,assign)CGPoint beginPoint; /**<起始点*/
@property (nonatomic,assign)CGPoint centerPoint; /**<圆心*/
@property (nonatomic,assign)CGPoint lastPoint; /**<上次滑动的点*/
@property (assign, nonatomic) CGFloat totalRads; /**<划过的总角度*/

@end


#define pi M_PI
#define degreesToRadian(x) (pi * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / pi)

@implementation LayoutDemoViewController

#pragma mark - Life Cycle
//系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载页面
    [self assignDate];
    [self settingAppearance];
    [self loadSubViews];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //布局
}
#pragma mark - Intial Methods
//初始化数据
- (void)assignDate {
    _dataSource = [[NSMutableArray alloc] init];
    _itemHeights = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 8; i ++) {
        
        [_dataSource addObject:[NSString stringWithFormat:@"%d",i]];
        
        CGFloat itemHeight = arc4random() % 200 + 20;
        [_itemHeights addObject:@(itemHeight)];
    }
}

- (void)settingAppearance {
    
}

- (void)loadSubViews {
//    LayoutDemo1 *layout = [[LayoutDemo1 alloc] init];
//    layout.layoutDelegate = self;
    
    RotationLayout *layout = [[RotationLayout alloc] init];

    self.rotationLayout = layout;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor redColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:_collectionView];
    
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(test:)];
    tap.delegate = self;
    [self.collectionView addGestureRecognizer:tap];
    
    self.centerPoint = self.collectionView.center;
}



#pragma mark - Target Methods
//点击事件

- (void)test:(UIPanGestureRecognizer *)tap {
    
    
    CGPoint point = [tap locationInView:tap.view];
    CGFloat rLength = sqrt(pow((point.x - _centerPoint.x), 2.0)  +  pow((point.y - _centerPoint.y), 2.0));
    
    
    float _larRadius = 200;
     float _itemRadius = 76;
    // 手势范围
    if (rLength <= _larRadius && rLength >= _larRadius - _itemRadius) {
        // 以collectionView center为中心计算滑动角度
        CGFloat rads = [self angleBetweenFirstLineStart:_centerPoint
                                           firstLineEnd:_lastPoint
                                     andSecondLineStart:_centerPoint
                                          secondLineEnd:point];
        
        if (_lastPoint.x != _centerPoint.x && point.x != _centerPoint.x) {
            
            CGFloat k1 = (_lastPoint.y - _centerPoint.y) / (_lastPoint.x - _centerPoint.x);
            CGFloat k2 = (point.y - _centerPoint.y) / (point.x - _centerPoint.x);
            if (k2 > k1) {
                _totalRads += rads;
            } else {
                _totalRads -= rads;
            }
        }
        
        self.rotationLayout.rotationAngle = _totalRads;
        // 重新布局
        [self.rotationLayout invalidateLayout];
        
        // 更新记录点
        _lastPoint = point;
    }
    // 由范围外进入范围内时将当前点赋值于记录点
    else if (_lastPoint.x == -100 && _lastPoint.y == -100) {
        _lastPoint = point;
    }
    // 由范围内进入范围外时清除记录点
    else {
        _lastPoint = CGPointMake(-100, -100);
    }
    
    

}
// 两条直线之间的夹角
- (CGFloat)angleBetweenFirstLineStart:(CGPoint)firstLineStart
                         firstLineEnd:(CGPoint)firstLineEnd
                   andSecondLineStart:(CGPoint)secondLineStart
                        secondLineEnd:(CGPoint)secondLineEnd
{
    CGFloat a1 = firstLineEnd.x - firstLineStart.x;
    CGFloat b1 = firstLineEnd.y - firstLineStart.y;
    CGFloat a2 = secondLineEnd.x - secondLineStart.x;
    CGFloat b2 = secondLineEnd.y - secondLineStart.y;
    
    // 夹角余弦
    double cos = (a1 * a2 + b1 * b2) / (sqrt(pow(a1, 2.0) + pow(b1, 2.0)) * sqrt(pow(a2, 2.0) + pow(b2, 2.0)));
    // 浮点计算结果可能超过1，需要控制
    cos = cos > 1 ? 1 : cos;
    return acos(cos);
}
#pragma mark - Network Methods
//网络请求

#pragma mark - Public Method
//外部方法

#pragma mark - Private Method
//私有方法

#pragma mark - Delegate
//代理方法
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor yellowColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [cell addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell);
    }];
    
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - CustomCollectionViewLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(LayoutDemo1 *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(SCREEN_WIDTH / 2 - 3 * 10, [_itemHeights[indexPath.row] floatValue]);
}


#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 初始滑动时记录点为当前点
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
        _lastPoint = point;
        
        
    }
    return YES;
}

#pragma mark - Lazy Loads

@end
