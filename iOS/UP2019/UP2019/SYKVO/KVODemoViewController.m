//
//  KVODemoViewController.m
//  UP2019
//
//  Created by Yunis on 2019/6/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "KVODemoViewController.h"
#import "KVOTestModel.h"
#import "SYKVO.h"
@interface KVODemoViewController ()

@end

@implementation KVODemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    KVOTestModel *model = [KVOTestModel new];

    [model addObserver:self forKeyPath:@"name" options:0 handle:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        NSLog(@"1 observedKey == %@",observedKey);
    }];
    [model addObserver:model forKeyPath:@"name" options:0 handle:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        NSLog(@"2 observedKey == %@",observedKey);
    }];
    
    model.name = @"111111111";
    model.address = @"-------------";
    NSLog(@"====================================================");

    [model removeObserver:self forKeyPath:@"name"];
    
    model.name = @"wwwwwwwww";
    model.address = @"~~~~~~~~~~~~~~~~~";

}


@end
