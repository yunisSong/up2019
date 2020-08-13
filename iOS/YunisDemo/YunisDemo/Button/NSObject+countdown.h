//
//  NSObject+countdown.h
//  YunisDemo
//
//  Created by Yunis on 2020/7/14.
//  Copyright © 2020 Yunis. All rights reserved.
//


#import <Foundation/Foundation.h>
//倒计时
@interface NSObject (countdown)
- (void)startCountdownWithTime:(NSInteger)time withCountDownBlock:(void(^)(NSInteger lastTime))countDownBlock;
@end


