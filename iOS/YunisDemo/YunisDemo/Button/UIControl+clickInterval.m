//
//  UIControl+clickInterval.m
//  YunisDemo
//
//  Created by Yunis on 2020/7/14.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "UIControl+clickInterval.h"
#import <objc/runtime.h>

@implementation UIControl (clickInterval)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(sy_SendAction:to:forEvent:);
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else {
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

- (NSTimeInterval)clickInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setClickInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, @selector(clickInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sy_SendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
	
	//1.判断是否设置了时间间隔
	if (!self.clickInterval || self.clickInterval <= 0) {
		//2.如果没有设置时间间隔 不hook
		[self sy_SendAction:action to:target forEvent:event];
        return;
	}else
	{
		//3.如果设置了时间间隔 hook
		
		//获取上次点击时间 比较间隔
		if (NSDate.date.timeIntervalSince1970 - self.lastTimeInterval < self.clickInterval) {
			return;
		}
		self.lastTimeInterval = NSDate.date.timeIntervalSince1970;
		[self sy_SendAction:action to:target forEvent:event];
	}

}


- (CFTimeInterval)lastTimeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setLastTimeInterval:(CFTimeInterval)lastTimeInterval {
    objc_setAssociatedObject(self, @selector(lastTimeInterval), @(lastTimeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
