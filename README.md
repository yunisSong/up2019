# up2019
up!up!up!

### 脚本

[打包脚本](./Shell|Python/打包脚本)

[去除文件名中的空格](./Shell|Python/去除文件名中的空格/changeBlankTo_)


### medium 

[5 Steps to Unit Test your Code Daily](./medium/5_Steps_to_Unit_Test_your_Code_Daily.md) 

[How_to_automate_CI_for_any_iOS_Project](./medium/How_to_automate_CI_for_any_iOS_Project.md) 

### 算法
[LeetCode](./LeetCode)



### iOS
#### [视觉差动画](./iOS/UP2019/UP2019/视觉差动画)

关键点在于滑动视图的时候，在滑动的代理方法里面修改图片的位置。

```


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取表视图的可见单元格。(可见的视图)
    NSArray *visibleCells = [self.tab visibleCells];
    for (Demo1TableViewCell *cell in visibleCells) {
        //可见视图设置->背景图片y值
        [cell cellOnTableView:self.tab didScrollView:self.view];
    }
}

--- cell

- (void)cellOnTableView:(UITableView *)tableView didScrollView:(UIView *)view
{
    //获取当前 cell 在 view 的坐标 rect
    CGRect rect = [tableView convertRect:self.frame toView:view];
    //view 高度
    float height = view.bounds.size.height;
    //根据 rect 的y 值 计算出 image 的偏移量
    self.topLayout.constant = -(rect.origin.y) * (self.heightLayout.constant/height);
}
```

#### [多级菜单](./iOS/UP2019/UP2019/多级菜单)

关键点是判断 model 记录的是 展开 还是关闭状态，然后根据状态去 Tableview 里面，插入或者删除数据。


```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CityModel *model = [BaseModel.displayArray objectAtIndex:indexPath.row];
    if (!model.items) {
        return;
    }
    model.open = !model.isOpen;
    [tableView beginUpdates];
    NSMutableArray * t = [NSMutableArray new];
    for (int i= 0; i < BaseModel.reloadCount ; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row + i + 1 inSection:0];
        [t addObject:index];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (model.open)
    {
        [tableView insertRowsAtIndexPaths:t withRowAnimation:UITableViewRowAnimationTop];
    }else
    {
        [tableView deleteRowsAtIndexPaths:t withRowAnimation:UITableViewRowAnimationBottom];
    }
    [tableView endUpdates];

}
```

#### [瀑布流](./iOS/UP2019/UP2019/瀑布流)
##### 瀑布流

```
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
```
##### 环形转盘


```
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
```

#### [日期百分比](./iOS/UP2019/UP2019/日期百分比)

关键点就是计算出当前日期是当前年、月的第几天。

#### [可点击Label](./iOS/UP2019/UP2019/可点击Label)


```
    SYTouchLabel *label = [[SYTouchLabel alloc] init];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    label.text = @"是的阿萨德法师是的阿萨德法师是的建设eeeeeeeeeeeeeeeeeeeeeeeeee社会主义新中国萨德法师是的阿萨德法师是的阿萨德法师是的阿萨德法师是的阿萨德法师";
    label.sy_clickString = @"eeeeeeeeeeeeeeeeeeeeeeeeee";
    label.sy_clickRange = NSMakeRange(2, 5 );
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).offset(- 40);
    }];
    
    label.clickBlock = ^(NSString *clickString)
    {
        NSLog(@"点击的文本为 %@",clickString);
    };
```

