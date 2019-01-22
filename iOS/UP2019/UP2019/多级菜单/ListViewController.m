//
//  ListViewController.m
//  UP2019
//
//  Created by Yunis on 2019/1/17.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "ListViewController.h"

#import "CityTableViewCell.h"
#import "CityModel+index.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray <CityModel *>*items;
@property(nonatomic,strong)CityModel *allCity;


@end

@implementation ListViewController

#pragma mark - Life Cycle
//系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载页面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self assignDate];

    });
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

    MBProgressHUD *hub =HUDLoading(@"", self.view);

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // something
        self.allCity = [CityModel allCity];
        dispatch_async(dispatch_get_main_queue(), ^{
            // something
            [hub hide:YES];
            [self.tab reloadData];
        });
    });
}


- (void)settingAppearance {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadSubViews {
    [self.view addSubview:self.tab];
    [self.tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}



#pragma mark - Target Methods
//点击事件

#pragma mark - Network Methods
//网络请求

#pragma mark - Public Method
//外部方法

#pragma mark - Private Method
//私有方法
- (int )countIndex:(CityModel *)model {
    if (model.isOpen)
    {
        return model.items.count;
    }else
    {
        return 1;
    }
}
#pragma mark - Delegate
//代理方法

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CityModel *model = [BaseModel.displayArray objectAtIndex:indexPath.row];
    model.open = !model.isOpen;
    [tableView reloadData];
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = BaseModel.displayArray.count;

    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell"
                                                            forIndexPath:indexPath];
    [cell configModel:BaseModel.displayArray[indexPath.row]];
    return cell;
}
#pragma mark - Lazy Loads
- (UITableView *)tab {
    if (_tab == nil) {
        _tab = ({
            UITableView *baseTableView    = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            [baseTableView registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CityTableViewCell"];
            baseTableView.delegate = self;
            baseTableView.dataSource = self;
//            baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            baseTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            baseTableView;
        });
    }
    return _tab;
}
@end
