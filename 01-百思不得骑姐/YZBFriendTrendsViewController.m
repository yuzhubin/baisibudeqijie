//
//  YZBFriendTrendsViewController.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBFriendTrendsViewController.h"

@implementation YZBFriendTrendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //view已成为导航栏的子栏，现在设置导航栏内容
    //首先设置导航栏中间的图片，标题
    self.navigationItem.title = @"我的关注";
    
    //如果使用self.title来实现，则导航栏跟tabbarbutton的标题文字会同时被修改，不建议使用
    
    //设置导航栏左边图片内容，因为导航栏leftBarButtonItem本身的方法不支持直接设定选中和普通状态两种图片样式，需要自定义一个button作为UIBarButtonItem再把它赋值给leftBarButtonItem
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    //note，如果没有设置button的size则button不会显示，此处的size为pch文件中添加的一个cgsize属性
    tagButton.size = tagButton.currentBackgroundImage.size;
    
    //为按钮添加触发的事件tagClick
    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
}

- (void) tagClick
{
    YZBLog(@"tagbutton clicked");
}

@end
