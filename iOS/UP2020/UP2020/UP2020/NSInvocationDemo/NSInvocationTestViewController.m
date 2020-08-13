//
//  NSInvocationTestViewController.m
//  UP2019
//
//  Created by Yunis on 2019/6/11.
//  Copyright © 2019年 Yunis. All rights reserved.
//

#import "NSInvocationTestViewController.h"
#import <objc/runtime.h>
@interface NSInvocationTestViewController ()

@end
// Block internals.
typedef NS_OPTIONS(int, TBVBlockFlags) {
    TBVBlockFlagsHasCopyDisposeHelpers = (1 << 25),
    TBVBlockFlagsHasSignature          = (1 << 30)
};
typedef struct tbv_block {
    __unused Class isa;
    TBVBlockFlags flags;
    __unused int reserved;
    void (__unused *invoke)(struct tbv_block *block, ...);
    struct {
        unsigned long int reserved;
        unsigned long int size;
        // requires TBVBlockFlagsHasCopyDisposeHelpers
        void (*copy)(void *dst, const void *src);
        void (*dispose)(const void *);
        // requires TBVBlockFlagsHasSignature
        const char *signature;
        const char *layout;
    } *descriptor;
    // imported variables
} *TBVBlockRef;

static NSMethodSignature *tbv_signatureForBlock(id block) {
    TBVBlockRef layout = (__bridge TBVBlockRef)(block);
    
    // 没有签名，直接返回空
    if (!(layout->flags & TBVBlockFlagsHasSignature)) {
        return nil;
    }
    
    // 获取 descriptor 指针
    void *desc = layout->descriptor;
    
    // 跳过 reserved 和 size 成员
    desc += 2 * sizeof(unsigned long int);
    
    // 如果有 Helpers 函数， 跳过 copy 和 dispose 成员
    if (layout->flags & TBVBlockFlagsHasCopyDisposeHelpers) {
        desc += 2 * sizeof(void *);
    }
    
    // desc 为 signature 指针的地址，转换下给 objcTypes
    char *objcTypes = (*(char **)desc);
    
    return [NSMethodSignature signatureWithObjCTypes:objcTypes];
}

@implementation NSInvocationTestViewController
/*
 
 NSInvocation是调用函数的另一种方式，
 它将调用者，函数名，参数封装到一个对象，然后通过一个invoke函数来执行被调用的函数，
 其思想就是命令者模式，将请求封装成对象。

 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     实例对象的方法位于 实例对象 isa 指针指向的 Class 的方法列表里面。
     类方法位于 类对象 isa 指针指向的 MetaClass 的方法列表里面。

     [xxx methodSignatureForSelector:@select];
     在 xxx 的 isa 指向的地方的方法列表里面找方法
     [xxx instanceMethodSignatureForSelector:@select];
     直接在 xxx 的 方法列表里面找方法

     
     + (nullable NSMethodSignature *)signatureWithObjCTypes:(const char *)types;
     
     根据字符生成方法签名
     
     */
    
    //通过NSInvocation 调用实例方法
    [self demo1];
    //通过NSInvocation 调用类方法
    [self demo2];
    //获取通过 NSInvocation 调用方法的返回值
    [self demo3];

    [self demo4];
}

- (void)demo1 {
    NSMethodSignature *signature = [NSInvocationTestViewController instanceMethodSignatureForSelector:@selector(testInstanceMethodArgument1:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = @selector(testInstanceMethodArgument1:);
    NSString *argument1 = @"string";
    [invocation setArgument:&argument1 atIndex:2];
    [invocation invoke];
}

- (void)testInstanceMethodArgument1:(NSString*)Argument1{
    NSLog(@" %@ ",Argument1);
}


- (void)demo2 {
    NSMethodSignature*signature = [object_getClass([NSInvocationTestViewController class]) instanceMethodSignatureForSelector:@selector(testClassMethod)];
    NSLog(@"signature = %@",signature);
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = [NSInvocationTestViewController class];
    invocation.selector = @selector(testClassMethod);
    [invocation invoke];
}
+ (void)testClassMethod
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)demo3 {
    NSMethodSignature*signature = [NSInvocationTestViewController instanceMethodSignatureForSelector:@selector(testReturnValue:)];
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = @selector(testReturnValue:);
    NSString *argument1 = @"----123---";
    [invocation setArgument:&argument1 atIndex:2];
    [invocation invoke];
    
    
    void *returnValue = NULL;
    NSLog(@"1 returnValue == %@",returnValue);
    [invocation getReturnValue:&returnValue];
    NSLog(@"2 returnValue == %@",returnValue);
    NSString *t = (__bridge NSString *)(returnValue);
    NSLog(@"t %p",t);
    

    /*
     NSString *returnValue;
     NSLog(@"1 returnValue == %@",returnValue);
     [invocation getReturnValue:&returnValue];
     NSLog(@"2 returnValue == %@",returnValue);
     NSLog(@"returnValue %p",returnValue);
     *** -[CFString release]: message sent to deallocated instance 0x60000025db30
     */
}
- (NSString *)testReturnValue:(NSString *)str1
{
    return [@"SSS" stringByAppendingString:str1];
}
- (void)demo4 {
    
    void (^yunisBlock)(NSString *str,Class cls) = ^void(NSString *str,Class cls) {
        NSLog(@"参数为 ： %@ %@",str,cls);
    };
    yunisBlock(@"ssss",[NSBundle class]);
    NSMethodSignature *methodSignature = tbv_signatureForBlock(yunisBlock);
    NSInvocation *blockInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    blockInvocation.target = yunisBlock;
    /*
     methodSignature 第一个参数是返回类型 第二个参数才是真正的参数
     `block` 的签名不像 `select`， 第一个参数是返回类型，第二个参数才是真正的参数，并不像 `select` 第二个参数是 `:` 代表 `SEL`.
     */
    for (int idx = 1; idx < methodSignature.numberOfArguments; idx++) {
        
        // 获取参数类型
        const char *type = [methodSignature getArgumentTypeAtIndex:idx];
        NSLog(@"----%s",type);
        /*
         Type Encodings

         https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100%EF%BC%89
         */
        if ([[NSString stringWithUTF8String:type] isEqualToString:@"\@\"NSString\""] ) {
            NSString *argument1 = @"----123---";
            [blockInvocation setArgument:&argument1 atIndex:idx];
        }else if ([[NSString stringWithUTF8String:type] isEqualToString:@"#"] )
        {
            Class cls = [NSSet class];
            [blockInvocation setArgument:&cls atIndex:idx];
        }
    }
    
    [blockInvocation invoke];
}

@end
