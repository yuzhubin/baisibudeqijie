//
//  YZBMeViewController.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBMeViewController.h"

@implementation YZBMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //view已成为导航栏的子栏，现在设置导航栏内容
    //首先设置导航栏中间的图片，标题
    self.navigationItem.title = @"我的";
    
    //设置导航栏左边图片内容，因为导航栏leftBarButtonItem本身的方法不支持直接设定选中和普通状态两种图片样式，需要自定义一个button作为UIBarButtonItem再把它赋值给leftBarButtonItem
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    //note，如果没有设置button的size则button不会显示，此处的size为pch文件中添加的一个cgsize属性
    settingButton.size = settingButton.currentBackgroundImage.size;
    
    //为按钮添加触发的事件settingButtonClick
    [settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //设置导航栏左边图片内容，因为导航栏leftBarButtonItem本身的方法不支持直接设定选中和普通状态两种图片样式，需要自定义一个button作为UIBarButtonItem再把它赋值给leftBarButtonItem
    UIButton *moonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moonButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    //note，如果没有设置button的size则button不会显示，此处的size为pch文件中添加的一个cgsize属性
    moonButton.size = moonButton.currentBackgroundImage.size;
    
    //为按钮添加触发的事件moonButtonClick
    [moonButton addTarget:self action:@selector(moonButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //note:添加多个button的数组，视图排列顺序是从右边开始排的，如果左边需要多个，使用leftBarButtonItems来设定即可
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithCustomView:settingButton],
                                                [[UIBarButtonItem alloc] initWithCustomView:moonButton]
                                                    ];
}


- (void) settingButtonClick
{
    YZBLog(@"settingButtonClick clicked");
}

- (void) moonButtonClick
{
    YZBLog(@"moonButtonClick clicked");
}


@end
