//
//  AppDelegate.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "AppDelegate.h"
#import "YZBTabBarController.h"
#import "YZBPushGuideView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建一个窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //设置窗口的根控制器
    UITabBarController *tabBarCOntroller = [[YZBTabBarController alloc] init];
    self.window.rootViewController = tabBarCOntroller;
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    NSString *key = @"CFBundleShortVersionString";
    
    //当前软件版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    //沙盒中存储的软件版本号
    NSString *sandBox = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    //判断是否新版本,如果是第一次才显示这个推送页面
    if (![version isEqualToString:sandBox]) {
        //添加首页消息推送view
        YZBPushGuideView *view = [YZBPushGuideView guideView];
        view.frame = self.window.bounds;
        
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.window addSubview:view];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
