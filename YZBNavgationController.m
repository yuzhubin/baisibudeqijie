//
//  YZBNavgationController.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/20.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBNavgationController.h"

@implementation YZBNavgationController

//所有仅需要第一次初始化的属性都可以放到initialize来做，以提高性能
+ (void)initialize
{
    //将背景图片设置放到导航控制器自定义类来处理
    //另一种方法，通过appearance特性来设置全局的背景图片，但是这么做，会导致所有的UINavigationBar都会被设置，所以用appearanceWhenContainedInInstancesOfClasses添加只有本控制器才会生效的约束
    //将这个处理放到initialize来，则只会在第一次使用这个类的时候调用，不会多次调用
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

//通过重写pushViewController，可以拦截pushview时间并作处理
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //push进去时子控制器数量就会大于0，如果不是第一个控制器则可以设置
    if (self.childViewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        //设置button的大小
        //[btn sizeToFit];
        //另一种方法,通过contentHorizontalAlignment属性设置，使其左对齐
        btn.size = CGSizeMake(70, 30);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //调节这个button的边缘位置
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        //设置不同状态下的文字颜色
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        //添加导航栏返回键标题，必须在触发跳转的view设置这个标题，在跳转后到达的view设置无效
        viewController.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        //当进入push后的界面时，隐藏掉底下的bar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //这句push一定要后面，让super的viewcontroller可以覆盖这个leftbaritem的属性
    [super pushViewController:viewController animated:animated];
}

//调用popViewControllerAnimated方法即可返回上一级
- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
