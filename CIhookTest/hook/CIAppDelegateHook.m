//
//  CIAppDelegateHook.m
//  CIhookTest
//
//  Created by spomer on 2017/8/12.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import "CIAppDelegateHook.h"

@implementation UIApplication(CIhook)

+ (void)load{

    [super load];
 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ //只执行一次就可以了
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(__gbh_tracer_applicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    });
}


+ (void)__gbh_tracer_applicationDidFinishLaunching:(NSNotification *)noti{
    //应用启动时为所欲为!
}



@end
