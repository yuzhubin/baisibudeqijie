//
//  YZBFriendTrendsViewController.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBFriendTrendsViewController.h"
#import "YZBReconmendViewController.h"

@implementation YZBFriendTrendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //view已成为导航栏的子栏，现在设置导航栏内容
    //首先设置导航栏中间的图片，标题
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    //此处用宏定义实现对颜色的统一控制（pch文件中）
    self.view.backgroundColor = YZBBackGroundColor;
}

- (void) friendsClick
{
    YZBReconmendViewController *vc = [[YZBReconmendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
