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

    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonClick)];
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonButtonClick)];

    self.navigationItem.rightBarButtonItems = @[settingButton, moonButton];
    
    self.view.backgroundColor = YZBBackGroundColor;
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
