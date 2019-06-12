//
//  UIViewController+backgroundColor.m
//  UP2019
//
//  Created by Yunis on 2019/6/11.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "UIViewController+backgroundColor.h"
#import <objc/runtime.h>
@implementation UIViewController (backgroundColor)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        SEL oldWillAppear = @selector(viewWillAppear:);
        SEL newWillAppear = @selector(statistics_viewWillAppear:);
        [UIViewController exchangeoldSEL:oldWillAppear newSEL:newWillAppear];
    
    });
}
+ (void)exchangeoldSEL:(SEL)old newSEL:(SEL)new
{
    Class class=[self class];
    
    SEL originalSelector= old;
    SEL swizzledSelector= new;
    
    Method originalMethod=class_getInstanceMethod(class,originalSelector);
    Method swizzledMethod=class_getInstanceMethod(class,swizzledSelector);
    
    BOOL didAddMethod=
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if(didAddMethod){
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod,swizzledMethod);
    }
}

-(void)statistics_viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self statistics_viewWillAppear:animated];
    
}
@end
