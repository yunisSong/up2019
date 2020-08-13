//
//  DemoViewController.m
//  YunisDemo
//
//  Created by Yunis on 2020/7/15.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "DemoViewController.h"
#import "UIControl+clickInterval.h"
#import "NSObject+countdown.h"
#import "SYMultipleLayoutButton.h"
@interface DemoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btr;
@property(nonatomic,strong)SYMultipleLayoutButton *layoutButton;
@end
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.btr.clickInterval = 2;
	SYMultipleLayoutButton *leftButton = [SYMultipleLayoutButton butonWithConfig:[SYElementConfig defaultConfig] title:@"天涯" iconImage:[UIImage imageNamed:@"icon_avatar_normal" ]];
	[self.view addSubview:leftButton];
	[leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.btr);
		make.top.equalTo(self.btr.mas_bottom).offset(40);
	}];
	[leftButton addClickHandle:^{
		NSLog(@"________");
	}];
	[leftButton addTarget:self select:@selector(click:)];
	self.layoutButton = leftButton;
	

}
- (IBAction)click:(id)sender {
	WS(weakSelf);
	[self.btr startCountdownWithTime:15 withCountDownBlock:^(NSInteger lastTime) {
		[weakSelf.btr setTitle:[NSString stringWithFormat:@"%ld",(long)lastTime] forState:UIControlStateNormal];
		weakSelf.layoutButton.title = [NSString stringWithFormat:@"天涯  %ld",(long)lastTime];

	}];
	
}

- (void)dealloc
{
	NSLog(@"DemoViewController dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
