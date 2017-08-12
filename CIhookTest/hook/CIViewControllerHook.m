//
//  CIViewControllerHook.m
//  CIhookTest
//
//  Created by spomer on 2017/8/12.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import "CIViewControllerHook.h"
#import <objc/runtime.h>

@implementation UIViewController (CIhook)

+ (void)load{
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 假如要打开controller的统计 ,则把下面这行代码打开
        __gbh_tracer_swizzleMethod([self class], @selector(viewDidAppear:), @selector(__gbh_tracer_viewDidAppear:));
        __gbh_tracer_swizzleMethod([self class], @selector(viewWillAppear:), @selector(__gbh_tracer_viewWillAppear:));
    });
}


void __gbh_tracer_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



- (void)__gbh_tracer_viewDidAppear:(BOOL)animated{
    [self __gbh_tracer_viewDidAppear:animated];  //由于方法已经被交换,这里调用的实际上是viewDidAppear:方法
    
    //设置不允许发送数据的Controller
    NSArray *filter = @[@"UINavigationController",@"UITabBarController"];
    NSString *className = NSStringFromClass(self.class);
    if ([filter containsObject:className]) return ; //如果该Controller在不允许发送log的列表里,则不能继续往下走
    
    if ([self.title isKindOfClass:[NSString class]] && self.title.length > 0){ //有标题的才符合我的要求
        // 这里发送log
    }
    NSLog(@"%@:the view has been fully transitioned onto the screen",[self class]);
}


- (void)__gbh_tracer_viewWillAppear:(BOOL)animated{
    [self __gbh_tracer_viewWillAppear:animated];
    
    //设置不允许发送数据的Controller
    NSArray *filter = @[@"UINavigationController",@"UITabBarController"];
    NSString *className = NSStringFromClass(self.class);
    if ([filter containsObject:className]) return ; //如果该Controller在不允许发送log的列表里,则不能继续往下走
    
    if ([self.title isKindOfClass:[NSString class]] && self.title.length > 0){ //有标题的才符合我的要求
        // 这里发送log
    }
   NSLog(@"%@:the view is about to made visible",[self class]);
    
}


@end
