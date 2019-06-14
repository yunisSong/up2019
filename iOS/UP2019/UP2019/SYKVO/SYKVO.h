//
//  SYKVO.h
//  UP2019
//
//  Created by Yunis on 2019/6/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_OPTIONS(NSUInteger, SYKeyValueObservingOptions) {
    
    SYKeyValueObservingOptionNew = 0x01,
    SYKeyValueObservingOptionOld = 0x02,
};
typedef void(^SYObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (SYKVO)
- (void)addObserver:(id)observer forKeyPath:(NSString *)keyPath options:(SYKeyValueObservingOptions)options handle:(SYObservingBlock)block;
- (void)removeObserverForKeyPath:(NSString *)keyPath;
- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer forKeyPath:(NSString *)keyPath;
@end

