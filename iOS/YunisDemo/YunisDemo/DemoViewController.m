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
#import "SYShowMoreLabel.h"


#import "UIView+SYLayoutHelp.h"
@interface DemoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btr;
@property(nonatomic,strong)SYMultipleLayoutButton *layoutButton;
@property(nonatomic,strong)SYShowMoreLabel *mLabel;
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
	
	SYShowMoreLabel *label = [SYShowMoreLabel new];
	NSString *text = @"就考虑考虑聚隆科技路口就少时诵诗书所士大夫士大夫；撒打发斯蒂芬士大夫撒旦法；士大夫撒打发斯蒂芬士大夫撒旦法；士大夫撒打发斯蒂芬士大夫撒旦法撒旦法是的；撒打发斯蒂芬士大夫大事发生的；工回复会覆盖；非共和国非；二；的发给对方；343；23；2；送公司；大范甘迪；发过的；发鬼地方；给对方；更新；查询；V型从；烦得很；个；";
	label.text = text;
	label.minNumbers = 2;
	[self.view st_addSubview:label mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self.view);
		make.top.equalTo(self.layoutButton.mas_bottom);
		make.height.greaterThanOrEqualTo(@100);
	}];
//	[self.view addSubview:label];
//	[label mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.right.equalTo(self.view);
//		make.top.equalTo(self.layoutButton.mas_bottom);
//	}];
	self.mLabel = label;
		

}
- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];

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
