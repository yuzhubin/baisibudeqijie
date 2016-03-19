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
    
    //根据父类itembar的描述，这个字典的key必须在NSAttributedString.h找，对应不同的属性设置
    //1.字体大小属性
    //2.字体颜色属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    //更改字体属性(选中时，主要区别在setTitleTextAttributes方法的forstate参数)
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    //tabbarItem类具有UI_APPEARANCE_SELECTOR属性(在父类baritem中可查到)，可以通过[UITabBarItem appearance]方法得到appearence属性进行统一的外观设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //添加子控制器
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.tabBarItem.title = @"精华";
    //更改字体属性（原方式，分别设置）
//    [vc1.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [vc1.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //此处要将渲染方法产生的新图片赋值给另一个指针
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.selectedImage = image;
    vc1.view.backgroundColor = [UIColor greenColor];
    
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.tabBarItem.title = @"新帖";
//    [vc2.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [vc2.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    UIImage *image2 = [UIImage imageNamed:@"tabBar_new_click_icon"];
    //此处要将渲染方法产生的新图片赋值给另一个指针
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.selectedImage = image2;
    vc2.view.backgroundColor = [UIColor blackColor];
    
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.tabBarItem.title = @"关注";
//    [vc3.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [vc3.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    UIImage *image3 = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    //此处要将渲染方法产生的新图片赋值给另一个指针
    image3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc3.tabBarItem.selectedImage = image3;
    vc3.view.backgroundColor = [UIColor blueColor];
    
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.tabBarItem.title = @"我";
//    [vc4.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [vc4.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    //此处没有使用image方法渲染，而是在accest里面直接修改图片的渲染属性，达到同样效果
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    vc4.view.backgroundColor = [UIColor grayColor];
    
    [self addChildViewController:vc4];
}


@end
