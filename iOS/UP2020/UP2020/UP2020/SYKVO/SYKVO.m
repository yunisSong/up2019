//
//  SYKVO.m
//  UP2019
//
//  Created by Yunis on 2019/6/13.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "SYKVO.h"
#include <pthread.h>
#import <objc/runtime.h>
#import <objc/message.h>

static NSString *const SYKVOSubclassSuffix = @"_SYKVO_";
static NSString *const SYKVOMessagePrefix = @"SYKVO_";

@interface SYKVOInfo:NSObject
@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) SYObservingBlock block;
+ (instancetype)infoWithObserver:(NSObject *)observer key:(NSString *)key handel:(SYObservingBlock)block;
@end
@implementation SYKVOInfo
+ (instancetype)infoWithObserver:(NSObject *)observer key:(NSString *)key handel:(SYObservingBlock)block
{
    SYKVOInfo *info = [SYKVOInfo new];
    info.observer = observer;
    info.key = key;
    info.block = block;
    return info;
}
@end
@implementation NSObject (SYKVO)
- (void)addObserver:(id)observer forKeyPath:(NSString *)keyPath options:(SYKeyValueObservingOptions)options handle:(SYObservingBlock)block
{
    /*
     1. 先判断是否响应 set 方法
     2. 判断是否响应 SYKVO_set 方法
     3. 添加 SYKVO_set 指向 set 的实现 （如果使用 objc_msgSendSuperCasted 上面两部可以不要）
     4. 替换 set 方法实现 kvo_setter
     5. 保存回调方法
     */
    sykvo_performLocked(^{
        
        NSString *selectname = [self selectNameWithKayPath:keyPath];
        SEL select = NSSelectorFromString(selectname);
        if ([self respondsToSelector:select]) {
            NSString *prefixSelectName = [self prefixSelectName:selectname];
            SEL prefixSelect = NSSelectorFromString(prefixSelectName);
            
            if (![self respondsToSelector:prefixSelect]) {
                Class klass = aspect_hookClass(self);
                //1 获取原来的 set 方法的实现 新增方法指向原来set方法的实现
                //如果使用 objc_msgSendSuperCasted 这一步可以不要
                sykvo_addMethod(klass, prefixSelect, sykvo_getMethod(klass, select));
                //2. 将原来的 set 方法指向新的实现
                Method targetMethod = class_getInstanceMethod(klass, select);
                const char *typeEncoding = method_getTypeEncoding(targetMethod);
                class_replaceMethod(klass, select, (IMP)kvo_setter, typeEncoding);
                //3.观察者
                SYKVOInfo *info = [SYKVOInfo infoWithObserver:observer key:keyPath handel:block];
                [[self syObserverSet] addObject:info];
            }
        }
    });
}
- (void)removeObserverForKeyPath:(NSString *)keyPath
{
    sykvo_performLocked(^{
        
        for (int i = ((int)([self syObserverSet].count - 1)); i >= 0; i--) {
            SYKVOInfo *info = [self syObserverSet][i];
            if ([info.key isEqualToString:keyPath]) {
                [[self syObserverSet] removeObject:info];
            }
        }
    });
 
}
- (void)removeObserver:(id)observer
{
    sykvo_performLocked(^{
        
        for (int i = ((int)([self syObserverSet].count - 1)); i >= 0; i--) {
            SYKVOInfo *info = [self syObserverSet][i];
            if (info.observer == observer) {
                [[self syObserverSet] removeObject:info];
            }
        }
    });
}
- (void)removeObserver:(id)observer forKeyPath:(NSString *)keyPath
{
    sykvo_performLocked(^{
        
        for (int i = ((int)([self syObserverSet].count - 1)); i >= 0; i--) {
            SYKVOInfo *info = [self syObserverSet][i];
            if (info.observer == observer) {
                if ([info.key isEqualToString:keyPath]) {
                    [[self syObserverSet] removeObject:info];
                    object_setClass(self, [self class]);
                }
            }
        }
    });
}
- (NSString *)selectNameWithKayPath:(NSString *)keyPath
{
    if (keyPath.length == 0) {
        //报错
        return @"";
    }
    NSString *capitalizedStr = [keyPath stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[keyPath substringToIndex:1] capitalizedString]];
    NSString *selectName = [[@"set" stringByAppendingString:capitalizedStr] stringByAppendingString:@":"];
    return selectName;
}
- (NSString *)prefixSelectName:(NSString *)selectName
{
    if (selectName.length == 0) {
        //报错
        return @"";
    }
    NSString *pselectName = [SYKVOMessagePrefix stringByAppendingString:selectName];
    return pselectName;
}
- (NSString *)getNameWithSetName:(NSString *)setName
{
    if (setName.length <= 4) {
        //报错
        return @"";
    }
    NSString *getName = [setName stringByReplacingCharactersInRange:NSMakeRange(0,3) withString:@""];
    NSString *getNameLow = [getName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[getName substringToIndex:1] lowercaseString]];
    
    return [getNameLow substringWithRange:NSMakeRange(0, getNameLow.length - 1)];
}
static void kvo_setter(id self, SEL _cmd, id newValue)
{
    
    //这里是新添加了一个方法指向了原来的实现，想当与调用原来的 set 方法
    NSString *setSeletName = NSStringFromSelector(_cmd);
    NSString *getSeletName = [self getNameWithSetName:setSeletName];
    id oldValue = [self valueForKey:getSeletName];
    
    //向父类发消息
    //此时类指向了动态创建的类 XXX_SYKVO_,他的父类就是 XXX
    //其实就相当于调用原来的方法
//    struct objc_super superInfo = {
//        self,
//        [self class]
//    };
//    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
//    objc_msgSendSuperCasted(&superInfo,_cmd,newValue);
    

    NSString *prefixSelectName = [self prefixSelectName:setSeletName];
    SEL prefixSelect = NSSelectorFromString(prefixSelectName);
    [self performSelector:prefixSelect withObject:newValue];
    
    for (SYKVOInfo *info in [self syObserverSet]) {
        if ([info.key isEqualToString:getSeletName]) {
            info.block(self, getSeletName, oldValue, newValue);
        }
    } 
}

static void sykvo_addMethod(Class class,SEL select,Method method) {
    // 获取方法的参数签名
    const char *typeEncoding = method_getTypeEncoding(method);
    //获取方法实现
    IMP targetMethodIMP = method_getImplementation(method);
    class_addMethod(class, select, targetMethodIMP, typeEncoding);
}


static Method sykvo_getMethod(Class class,SEL select) {
    Method targetMethod = class_getInstanceMethod(class, select);
    return targetMethod;
}
static void sykvo_performLocked(dispatch_block_t block) {
    static pthread_mutex_t mutex;

    pthread_mutex_lock(&mutex);
    block();
    pthread_mutex_unlock(&mutex);
}
static Class aspect_hookClass(NSObject *self) {
    NSCParameterAssert(self);
    Class statedClass = self.class;
    Class baseClass = object_getClass(self);
    NSString *className = NSStringFromClass(baseClass);
    if (statedClass != baseClass) {
        //已经 hook 过了。。
        return baseClass;
    }
    const char *subclassName = [className stringByAppendingString:SYKVOSubclassSuffix].UTF8String;
    Class subclass = objc_getClass(subclassName);
    
    //如果这个类还没有本创建过
    if (subclass == nil) {
        //创建 subclassName 的类，他的父类为 baseClass
        subclass = objc_allocateClassPair(baseClass, subclassName, 0);
        //如果创建失败，报错。
        if (subclass == nil) {
            NSString *errrorDesc = [NSString stringWithFormat:@"objc_allocateClassPair failed to allocate class %s.", subclassName];
            NSLog(@"%@",errrorDesc);
            return nil;
        }
        // 交换 class 方法的实现
        aspect_hookedGetClass(subclass, statedClass);
        //注册子类
        objc_registerClassPair(subclass);
    }
    
    // 把 self 的类指向 subclass
    object_setClass(self, subclass);
    return subclass;
}
static void aspect_hookedGetClass(Class class, Class statedClass) {
    NSCParameterAssert(class);
    NSCParameterAssert(statedClass);
    Method method = class_getInstanceMethod(class, @selector(class));
    IMP newIMP = imp_implementationWithBlock(^(id self) {
        return statedClass;
    });
    class_replaceMethod(class, @selector(class), newIMP, method_getTypeEncoding(method));
}
- (NSMutableArray *)syObserverSet
{
    NSMutableArray *mArray = objc_getAssociatedObject(self, @selector(syObserverSet));
    if (!mArray) {
        mArray = [NSMutableArray new];
        objc_setAssociatedObject(self, @selector(syObserverSet), mArray, OBJC_ASSOCIATION_RETAIN);
    }
    return mArray;
}
@end

