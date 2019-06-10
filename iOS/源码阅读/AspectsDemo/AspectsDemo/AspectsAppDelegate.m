//
//  AspectsAppDelegate.m
//  AspectsDemo
//
//  Created by Peter Steinberger on 03/05/14.
//  Copyright (c) 2014 PSPDFKit GmbH. All rights reserved.
//

#import "AspectsAppDelegate.h"
#import "AspectsViewController.h"
#import "Aspects.h"
#define AspectPositionFilter111 0x07

@implementation AspectsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AspectsViewController *aspectsController = [AspectsViewController new];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:aspectsController];
    [self.window makeKeyAndVisible];

    NSLog(@"AspectPositionAfter == %lx",AspectPositionAfter & AspectPositionFilter111);
    NSLog(@"AspectOptionAutomaticRemoval == %lx",AspectOptionAutomaticRemoval & AspectPositionFilter111);

    // Ignore hooks when we are testing.
    if (!NSClassFromString(@"XCTestCase")) {
//        [aspectsController aspect_hookSelector:@selector(buttonPressed:) withOptions:0 usingBlock:^(id info, id sender) {
//            NSLog(@"Button was pressed by: %@", sender);
//        } error:NULL];
        
        [aspectsController aspect_hookSelector:@selector(buttonPressed:) withOptions:AspectPositionAfter usingBlock:^(id info, id sender) {
            NSLog(@"Button was pressed by: %@", sender);
        } error:NULL];

        [aspectsController aspect_hookSelector:@selector(viewWillLayoutSubviews) withOptions:AspectOptionAutomaticRemoval usingBlock:^{
            NSLog(@"Controller is layouting!");
        } error:NULL];
    }

    return YES;
}

@end
