//
//  YZBTabBarController.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBTabBarController.h"

@implementation YZBTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加子控制器
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.tabBarItem.title = @"精华";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //此处要将渲染方法产生的新图片赋值给另一个指针
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.selectedImage = image;
    vc1.view.backgroundColor = [UIColor greenColor];
    
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.tabBarItem.title = @"新帖";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    UIImage *image2 = [UIImage imageNamed:@"tabBar_new_click_icon"];
    //此处要将渲染方法产生的新图片赋值给另一个指针
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.selectedImage = image2;
    vc2.view.backgroundColor = [UIColor blackColor];
    
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.tabBarItem.title = @"关注";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    UIImage *image3 = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    //此处要将渲染方法产生的新图片赋值给另一个指针
    image3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc3.tabBarItem.selectedImage = image3;
    vc3.view.backgroundColor = [UIColor blueColor];
    
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.tabBarItem.title = @"我";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    UIImage *image4 = [UIImage imageNamed:@"tabBar_me_click_icon"];
    //此处要将渲染方法产生的新图片赋值给另一个指针
    image4 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc4.tabBarItem.selectedImage = image4;
    vc4.view.backgroundColor = [UIColor grayColor];
    
    [self addChildViewController:vc4];
}


@end
