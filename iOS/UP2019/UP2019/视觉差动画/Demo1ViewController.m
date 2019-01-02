//
//  Demo1ViewController.m
//  ScrollowDemo
//
//  Created by Yunis on 2018/12/29.
//  Copyright © 2018年 Yunis. All rights reserved.
//

#import "Demo1ViewController.h"
#import "Demo1TableViewCell.h"
@interface Demo1ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@end

@implementation Demo1ViewController

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
//    self.navigationController.navigationBarHidden = YES;

}
#pragma mark - Intial Methods
//初始化数据
- (void)assignDate {
    
}

- (void)settingAppearance {
    
}

- (void)loadSubViews {
    [self.view addSubview:self.tab];
    self.tab.frame = self.view.bounds;
}



#pragma mark - Target Methods
//点击事件

#pragma mark - Network Methods
//网络请求

#pragma mark - Public Method
//外部方法

#pragma mark - Private Method
//私有方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}
//滚动监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取表视图的可见单元格。(可见的视图)
    NSArray *visibleCells = [self.tab visibleCells];
    for (Demo1TableViewCell *cell in visibleCells) {
        //可见视图设置->背景图片y值
        [cell cellOnTableView:self.tab didScrollView:self.view];
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Demo1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Demo1TableViewCell" forIndexPath:indexPath];
    int index = indexPath.row % 6;
    cell.ss_imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"DemoPic%d",index]];
    return cell;
}

#pragma mark - Lazy Loads
- (UITableView *)tab {
    if (_tab == nil) {
        _tab = ({
            UITableView *baseTableView    = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            [baseTableView registerNib:[UINib nibWithNibName:@"Demo1TableViewCell" bundle:nil] forCellReuseIdentifier:@"Demo1TableViewCell"];
            baseTableView.delegate = self;
            baseTableView.dataSource = self;
//            baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//            baseTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//            baseTableView.backgroundColor = [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1.00];
//            baseTableView.rowHeight = 100;
            baseTableView;
        });
    }
    return _tab;
}
@end
