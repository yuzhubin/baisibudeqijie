//
//  YZBPushGuideView.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/31.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBPushGuideView.h"

@implementation YZBPushGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    //当前软件版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    //沙盒中存储的软件版本号
    NSString *sandBox = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    //判断是否新版本,如果是第一次才显示这个推送页面
    if (![version isEqualToString:sandBox]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //添加首页消息推送view
        YZBPushGuideView *view = [YZBPushGuideView guideView];
        view.frame = window.bounds;
        
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [window addSubview:view];
    }
}

//增加这个属性作为类的主要bundle
+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)closeButton {
    [self removeFromSuperview];
}

@end
