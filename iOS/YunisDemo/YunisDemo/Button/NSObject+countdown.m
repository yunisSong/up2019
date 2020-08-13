//
//  NSObject+countdown.m
//  YunisDemo
//
//  Created by Yunis on 2020/7/14.
//  Copyright © 2020 Yunis. All rights reserved.
//

#import "NSObject+countdown.h"
#import <objc/runtime.h>


@implementation NSObject (countdown)
#define SYTimeInterval 1
- (void)startCountdownWithTime:(NSInteger)time withCountDownBlock:(void(^)(NSInteger lastTime))countDownBlock
{
	if (!countDownBlock) {
		return;
	}
	
	[self sy_setCurrentTime:time];
	[self setSY_Handle:countDownBlock];
	
	[self sy_timer];
}
- (void)countDown {
	NSInteger currentTime = [self currentTime];
	currentTime --;
	if (currentTime >= 0) {
		[self SY_Handle](currentTime);
		[self sy_setCurrentTime:currentTime];
	}else
	{
		[self setSY_Handle:nil];
		NSTimer *timer = [self sy_timer];
		[timer invalidate];
		timer = nil;
		[self sy_setTimer:timer];

	}
	
}
- (void)setSY_Handle:(void(^)(NSInteger lastTime))countDownBlock
{
    objc_setAssociatedObject(self, @selector(SY_Handle), countDownBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void(^)(NSInteger lastTime))SY_Handle {
    return objc_getAssociatedObject(self, _cmd);

}
- (NSTimer *)sy_timer {
	NSTimer *timer = objc_getAssociatedObject(self, @selector(sy_timer));
	if (!timer) {
		timer = [NSTimer timerWithTimeInterval:SYTimeInterval target:self selector:@selector(countDown) userInfo:nil repeats:YES];
		[self sy_setTimer:timer];
		[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
		[timer fire];
	}

	return timer;
}
- (void)sy_setTimer:(NSTimer *)timer
{
	objc_setAssociatedObject(self, @selector(sy_timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (NSInteger )currentTime {
	 return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)sy_setCurrentTime:(NSInteger )time {
	objc_setAssociatedObject(self, @selector(currentTime), @(time), OBJC_ASSOCIATION_ASSIGN);
}

@end
