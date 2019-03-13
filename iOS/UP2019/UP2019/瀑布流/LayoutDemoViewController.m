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
@interface LayoutDemoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CustomCollectionViewLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) RotationLayout *rotationLayout;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *itemHeights;
@property(nonatomic,assign)CGPoint beginPoint;
@property(nonatomic,assign)CGPoint centerPoint;


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
    [self.collectionView addGestureRecognizer:tap];
    
    self.centerPoint = self.collectionView.center;
}



#pragma mark - Target Methods
//点击事件

- (void)test:(UIPanGestureRecognizer *)tap {
    switch (tap.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint p = [tap locationInView:tap.view];
            _beginPoint = p;
            NSLog(@"begin = %@",NSStringFromCGPoint(p));
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint p = [tap locationInView:tap.view];

            NSLog(@"move = %@",NSStringFromCGPoint(p));

            CGFloat a = self.centerPoint.x - _beginPoint.x;
            CGFloat b = self.centerPoint.y - _beginPoint.y;
            CGFloat c = self.centerPoint.x - p.x;
            CGFloat d = self.centerPoint.y - p.y;
            
            CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
            NSLog(@"---------------rads == %f",radiansToDegrees(rads));
            
            // 浮点计算结果可能超过1，需要控制
            rads = rads > 1 ? 1 : rads;
            self.rotationLayout.rotationAngle = acos(rads);
            [self.rotationLayout invalidateLayout];

            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            CGPoint p = [tap locationInView:tap.view];

            NSLog(@"end = %@",NSStringFromCGPoint(p));

            break;
        }

        default:
            break;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint centerPoint = self.collectionView.center;
    UITouch *touch = touches.anyObject;
    CGPoint point  = [touch locationInView:self.collectionView];
    
    NSLog(@"begin %@",NSStringFromCGPoint(point));

}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint centerPoint = self.collectionView.center;
    UITouch *touch = touches.anyObject;
    CGPoint point  = [touch locationInView:self.collectionView];
    NSLog(@"move %@",NSStringFromCGPoint(point));


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

#pragma mark - Lazy Loads

@end
