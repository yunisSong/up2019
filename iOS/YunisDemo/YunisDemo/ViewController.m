//
//  ViewController.m
//  YunisDemo
//
//  Created by Yunis on 2020/7/14.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "TableViewDemoViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btr;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Do any additional setup after loading the view.

//	expand 扩大
//	倒计时 countdown
}
- (IBAction)click:(id)sender {
	NSLog(@"11111");
	[self.navigationController pushViewController:[TableViewDemoViewController new] animated:YES];

}


@end
