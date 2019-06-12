//
//  AspectsAppDelegate.m
//  AspectsDemo
//
//  Created by Peter Steinberger on 03/05/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//
@interface YunisTest:NSObject
+(void)printTest;
@end
@implementation YunisTest
+(void)printTest
{
    NSLog(@"qwe");
}
@end
#import "AspectsAppDelegate.h"
#import "AspectsViewController.h"
#import "Aspects.h"
@implementation AspectsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AspectsViewController *aspectsController = [AspectsViewController new];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:aspectsController];
    [self.window makeKeyAndVisible];

    // Ignore hooks when we are testing.
//    if (!NSClassFromString(@"XCTestCase")) {
//        [aspectsController aspect_hookSelector:@selector(buttonPressed:) withOptions:AspectPositionAfter usingBlock:^(id info, id sender) {
//            NSLog(@"Button was pressed by: %@", sender);
//        } error:NULL];
//
//        [aspectsController aspect_hookSelector:@selector(viewWillLayoutSubviews) withOptions:AspectPositionAfter usingBlock:^{
//            NSLog(@"Controller is layouting!");
//        } error:NULL];
//    }
    
    [YunisTest aspect_hookSelector:@selector(printTest) withOptions:AspectPositionInstead usingBlock:^{
        NSLog(@"11111111111111");
    } error:nil];
    [YunisTest printTest];
    return YES;
}

@end
