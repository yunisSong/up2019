//
//  SYChooseImageView.m
//  YXHeFei
//
//  Created by Yunis on 2020/1/8.
//  Copyright © 2020 天源迪科. All rights reserved.
//

#import "SYChooseImageView.h"
#import "ImageCollectionViewCell.h"
#import <TZImagePickerController/TZImagePickerController.h>
@interface SYChooseImageView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong,readwrite)NSArray <UIImage *>* images; /**<展示的图片*/
@property (nonatomic,strong) UICollectionView * imageListView;
@property (nonatomic,strong) NSMutableArray * dataSource;//设置图片
@property(nonatomic,copy)infoChangeFeedback handle;

@end


#define MAX_CHOOSE_NUM 9
#define SYChooseImageView_KImage(imageName) [UIImage imageNamed:imageName]
#define SYChooseImageView_photoCell_Height ((SCREEN_WIDTH -40)/3 + 15)

@implementation SYChooseImageView
#pragma mark - Life Cycle
//系统方法
+ (instancetype)showImageWithImages:(NSArray <UIImage *>*)images infoChangeFeedback:(infoChangeFeedback)handle
{
    return [[SYChooseImageView alloc] initWithImages:images imageURLs:nil infoChangeFeedback:handle];
}
+ (instancetype)showImageWithImageURLs:(NSArray <NSString *>*)imageURLs infoChangeFeedback:(infoChangeFeedback)handle
{
    return [[SYChooseImageView alloc] initWithImages:nil imageURLs:imageURLs infoChangeFeedback:handle];
}

- (instancetype)initWithImages:(NSArray <UIImage *>*)images imageURLs:(NSArray <NSString *>*)imageURLs infoChangeFeedback:(infoChangeFeedback)handle
{
    self = [super init];
    if (self) {
        self.handle = handle;
        self.dataSource = [NSMutableArray arrayWithArray:@[@{@"image":SYChooseImageView_KImage(@"addImage"),@"index":@"99"}]];
        [self listDataSourceAddImages:images imageURLs:imageURLs];
        [self addSubview:self.imageListView];
        [self.imageListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self refreshCollectionViewFrame];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"=========");
}
#pragma mark - Intial Methods
//初始化数据

#pragma mark - Target Methods
//点击事件

#pragma mark - Network Methods
//网络请求

#pragma mark - Public Method
//外部方法

#pragma mark - Private Method
//私有方法
- (void)refreshCollectionViewFrame {
    NSInteger number = ceilf(_dataSource.count / 3.0);

    
    [self.imageListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 15, 0, 15)).priority(889);
        make.height.mas_equalTo(SYChooseImageView_photoCell_Height * number).priority(889);
    }];
    [self.imageListView reloadData];
    [self updateConstraints];
    [self layoutIfNeeded];
    
    
    if (self.handle) {
        NSMutableArray *items = [NSMutableArray new];
        for (NSDictionary * dict in self.dataSource) {
            if (![dict[@"index"] isEqualToString:@"99"]) {
                UIImage *image = dict[@"image"];
                if (image) {
                    [items addObject:image ];
                }else {
//                    NSString *url = dict[@"imageURL"];
//                    UIImage *webImage = [[[SDWebImageManager sharedManager] imageCache] imageFromCacheForKey:url];
//                    if (webImage) {
//                        [items addObject:webImage ];
//                    }

                }
            }
        }
       
        self.handle(items, SYChooseImageView_photoCell_Height * number);
    }
    
}
-(void)showChoosePhotoAlert
{

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"" message:@"选择您要上传的图片" preferredStyle:UIAlertControllerStyleActionSheet];

    WS(weakSelf);
    UIAlertAction * libraryAction = [UIAlertAction actionWithTitle:@"拍照或从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf choosePhoto];
    }];

    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:libraryAction];
    [alertController addAction:cancelAction];
//    [self.viewController presentViewController:alertController animated:YES completion:nil];
    
}

- (void)choosePhoto {
    TZImagePickerController * pickerVC = [[TZImagePickerController alloc]
                                        initWithMaxImagesCount:MAX_CHOOSE_NUM - self.dataSource.count
                                        columnNumber:4
                                        delegate:nil
                                        pushPhotoPickerVc:YES];
    
    pickerVC.allowTakeVideo = NO;//不能拍摄视频
    pickerVC.allowPickingVideo = NO;//不能选择视频
    pickerVC.allowCameraLocation = NO;//不能定位
    WS(weakSelf);
    [pickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weakSelf listDataSourceAddImages:photos imageURLs:nil];
        [weakSelf refreshCollectionViewFrame];

    }];
//    [self.viewController presentViewController:pickerVC animated:YES completion:nil];
}

- (void)listDataSourceAddImages:(NSArray <UIImage *>*)images  imageURLs:(NSArray <NSString *>*)imageURLs{
    for (UIImage * img in images) {
       NSInteger count = _dataSource.count;
       [self.dataSource insertObject:@{@"image":img,@"index":@"0"} atIndex:count-1];
       if (self.dataSource.count > MAX_CHOOSE_NUM) {
           [self.dataSource removeLastObject];
       }
   }
    for (NSString * imgURL in imageURLs) {
        NSInteger count = _dataSource.count;
        [self.dataSource insertObject:@{@"imageURL":imgURL,@"index":@"0"} atIndex:count-1];
        if (self.dataSource.count > MAX_CHOOSE_NUM) {
            [self.dataSource removeLastObject];
        }
    }
}

#pragma mark - Delegate
//代理方法
#pragma mark -- collectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dataDict = _dataSource[indexPath.row];
    for (UIImageView *subView in cell.contentView.subviews) {
        [subView hiddenDeleteIcon];
    }
    cell.dataDict = dataDict;
    WS(weakSelf);
     __weak __typeof(&*indexPath)weakIndexPath = indexPath;
    [cell setHandel:^{
        [weakSelf removeItemWithIndex:weakIndexPath.row];
    }];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = _dataSource[indexPath.row];
    if ([dict[@"index"] isEqualToString:@"99"]) {
        [self showChoosePhotoAlert];
    }
}
#pragma mark -- 删除图片
- (void)removeItemWithIndex:(NSInteger )index {
    [_dataSource removeObjectAtIndex:index];
    if (_dataSource.count < 9 && ![_dataSource containsObject:@{@"image":SYChooseImageView_KImage(@"addImage"),@"index":@"99"}]) {
        [_dataSource addObject:@{@"image":SYChooseImageView_KImage(@"addImage"),@"index":@"99"}];
    }
    [self refreshCollectionViewFrame];
}
#pragma mark - Lazy Loads
- (UICollectionView *)imageListView {
    if (_imageListView == nil) {
        _imageListView = ({
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
            layout.itemSize = CGSizeMake((SCREEN_WIDTH -40)/3 , SYChooseImageView_photoCell_Height);
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 5;
            
            UICollectionView *_collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            _collection.backgroundColor = [UIColor whiteColor];
            _collection.delegate = self;
            _collection.dataSource = self;
            _collection.scrollEnabled = NO;
            [_collection registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
            
            if (@available(iOS 11.0, *)) {
                _collection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }


            _collection;
        });
    }
    return _imageListView;
}
@end
