//
//  ViewController.m
//  UP2019
//
//  Created by Yunis on 2019/1/2.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tab;
@property(nonatomic,strong)NSArray *sourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"[UIApplication sharedApplication].windows == %@",[UIApplication sharedApplication].windows);
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    [self.tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UP2019"];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.backgroundColor = [ UIColor yellowColor];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"1 [UIApplication sharedApplication].windows == %@",[UIApplication sharedApplication].windows);
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
            NSLog(@"1111111111");
            window.backgroundColor = [UIColor clearColor];
            [window removeFromSuperview];
            window.alpha = 0.f;
        }else
        {
            window.backgroundColor = [UIColor redColor];
        }
    }

}
#pragma mark - Delegate
//代理方法
#pragma mark -
#pragma mark Table View DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UP2019"];
    cell.textLabel.text = [self cellTitle:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= self.sourceArray.count) {
        return;
    }
    Class cls = NSClassFromString([self cellClass:indexPath]);
    if ( cls )
    {
        UIViewController *ctr = [cls new];
        ctr.title = [self cellTitle:indexPath];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}
- (NSArray *)sourceArray{
    if (_sourceArray == nil) {
        _sourceArray = ({
            NSArray *arr = @[
                             @{@"title":@"视觉差动画",@"class":@"Demo1ViewController"},
                             @{@"title":@"多级菜单",@"class":@"ListViewController"},
                             @{@"title":@"自定义卡片视图",@"class":@"CardViewController"},
                             @{@"title":@"日期百分比",@"class":@"SYYearViewController"},
                             @{@"title":@"瀑布流",@"class":@"LayoutDemoViewController"},
                             @{@"title":@"可点击label",@"class":@"RTFViewController"},
                             @{@"title":@"NSInvocation",@"class":@"NSInvocationTestViewController"},
                             @{@"title":@"手动实现 KVO ",@"class":@"KVODemoViewController"},
                             @{@"title":@"手动实现 KVO111 ",@"class":@"SYTestViewController"},

                             ];
            arr;
        });
    }
    
    return _sourceArray;
}
- (NSString *)cellTitle:(NSIndexPath *)index {
    NSDictionary *d = self.sourceArray[index.row];
    return d[@"title"];
}
- (NSString *)cellClass:(NSIndexPath *)index {
    NSDictionary *d = self.sourceArray[index.row];
    return d[@"class"];
}
@end
