//
//  YZBTabBar.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBTabBar.h"

@interface YZBTabBar()
//发布按钮
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation YZBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //可从tabbaritem的定义中得知tabbaritem类有一个tabbar的property用于显示这个tabbaritem的内容（点击debug里面的方形按钮也可在左侧的debug栏中看到），所以直接调用tabbar的addSubview方法可直接在这个bar加视图实例
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //选择背景图片
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        //在init中设置button的frame是无效的，layoutSubviews方法调用之后会失效，要在layoutSubviews中进行设置
        [self addSubview:publishButton];
        
        //把生成的button赋值给全局的button指针
        self.publishButton = publishButton;
    }
    
    return self;
}

//重写layoutSubviews方法是先自定义tabbar布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置button的frame
    //设置button大小
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
  
    //设置button的中心位置
    self.publishButton.center = CGPointMake(self.width*0.5, self.height*0.5);
    
    //计算位置值
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    //设置其他tabbarbutton(即其他现实的按钮)的frame
    for (UIView *button in self.subviews) {
        //使用isKindOfClass判断这个button是不是UITabBarButton，因为UITabBarButton这个属性是私有的，不能被直接调用，所以使用NSClassFromString方法取出这个class类型
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        
//        //第二种方法，已知UITabBarButton是属于UIControl的子类，而普通的button不是，通过非判断可定位。
//        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) {
//            continue;
//        }
        
        //判断index是否大于1（第三个普通tabbarbutton），进行处理
        CGFloat buttonX = buttonW * ((index > 1)?(index+1):index);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
}

@end
