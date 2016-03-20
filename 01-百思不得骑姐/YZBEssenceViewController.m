//
//  YZBEssenceViewController.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBEssenceViewController.h"

@implementation YZBEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //view已成为导航栏的子栏，现在设置导航栏内容
    //首先设置导航栏中间的图片，标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = YZBBackGroundColor;
}

- (void) tagClick
{
    YZBLog(@"tagbutton clicked");
}

@end
