//
//  YZBTabBarController.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBTabBarController.h"
#import "YZBEssenceViewController.h"
#import "YZBNewViewController.h"
#import "YZBFriendTrendsViewController.h"
#import "YZBMeViewController.h"
#import "YZBTabBar.h"

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
    [self setupChildVc:[[YZBEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[YZBNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[YZBFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[YZBMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //因为直接实例化的tabbarcontroller的tabbar属性，不能进行自定义，所以需要自定义一个tabbar并赋值
    //更换tabbar,因为tabbar是readonly的属性，所以才用kvc机制去自定义它
    //self.tabBar = [[YZBTabBar alloc] init];
    [self setValue:[[YZBTabBar alloc] init] forKey:@"tabBar"];
}

/**
*初始化子控制器
*1、因为viewcontroller就是一个tabbaritem，所以将viewcontroller的实例作为参数传入，并实现可自定义控制器类型及初始化方法
*2、传入title，image，selectedimage名称字符串，实现自定义标题及图片
**/
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //作为导航栏时起作用，作为导航栏标题名称
    //vc.navigationItem.title = title;
    
    //设置文字，图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    //此处没有使用image方法渲染，而是在accest里面直接修改图片的渲染属性，达到同样效果
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //设置背景色
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1];
    
    //根据界面需求，需要导航控制器，所以将当前界面包装到一个导航控制器中，将该view作为导航控制器的rootview，再addsubview
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    //添加子控制器,改进后，子控制器为导航控制器
    [self addChildViewController:nav];
}

@end
