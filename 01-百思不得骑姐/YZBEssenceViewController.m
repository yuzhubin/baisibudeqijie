//
//  YZBEssenceViewController.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBEssenceViewController.h"
#import "YZBReconmendTagsViewController.h"
#import "YZBAllViewController.h"
#import "YZBVideoViewController.h"
#import "YZBVoiceViewController.h"
#import "YZBImageViewController.h"
#import "YZBWordViewController.h"

@interface YZBEssenceViewController () <UIScrollViewDelegate>

//标签栏底部的红色指示器
@property (nonatomic, weak) UIView *indicatorview;
@property (nonatomic, weak) UIButton *selectedTitle;
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation YZBEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildVces];
    
    [self setupTitleView];
    
    [self setupScrollView];
}

//设置导航栏
- (void)setupNav
{
    //view已成为导航栏的子栏，现在设置导航栏内容
    //首先设置导航栏中间的图片，标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = YZBBackGroundColor;
}

//顶部导航按钮
- (void) tagClick
{
    YZBReconmendTagsViewController *vc = [[YZBReconmendTagsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//设置顶部标签栏
- (void)setupTitleView
{
    UIView *titlesView = [[UIView alloc] init];
    
    //titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.width = self.view.width;
    titlesView.height = YZBTitlesViewH;
    titlesView.y = YZBTitlesViewY;
    
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部红色指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.tag = -1;
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titlesView.height - indicator.height;
    self.indicatorview = indicator;
    
    //往view里面加标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width/titles.count;
    CGFloat height = titlesView.height;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        //绑定一个tag
        button.tag = i;
        
        button.height = height;
        button.width = width;
        button.x = i*width;
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        //如果没有立即布局显示，则button还没有宽度
        [button layoutIfNeeded];
        
        //此处@selector(titleClick:)里面的函数名加冒号，表示可以传参数
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titlesView addSubview:button];
        
        //默认选中第一个
        if (i == 0) {
            button.enabled = NO;
            self.selectedTitle = button;
            
            self.indicatorview.width = button.titleLabel.width;
            self.indicatorview.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicator];
}

- (void)titleClick:(UIButton *)button
{
    //使用disable控制，防止重复选中
    self.selectedTitle.enabled = YES;
    button.enabled = NO;
    self.selectedTitle = button;
    
    //用动画过渡会显得比较平滑
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorview.width = button.titleLabel.width;
        self.indicatorview.centerX = button.centerX;
    }];
    
    //滚动切换子控制器(利用切换当前视图水平位置偏移的方式)
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void)setupScrollView
{
    //设置为不自动加内容的初始插入间隔insert
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.backgroundColor = YZBBackGroundColor;
    scrollview.frame = self.view.bounds;
    
    //成为代理加载数据
    scrollview.delegate = self;
    
    [self.view insertSubview:scrollview atIndex:0];
    
    scrollview.contentSize = CGSizeMake(scrollview.width * self.childViewControllers.count, 0);
    
    self.contentView = scrollview;
    
    [self scrollViewDidEndScrollingAnimation:self.contentView];
}

- (void)setupChildVces
{
    YZBAllViewController *allView = [[YZBAllViewController alloc] init];
    YZBVideoViewController *videoView = [[YZBVideoViewController alloc] init];
    YZBVoiceViewController *voiceView = [[YZBVoiceViewController alloc] init];
    YZBImageViewController *imageView = [[YZBImageViewController alloc] init];
    YZBWordViewController *wordView = [[YZBWordViewController alloc] init];
    
    //添加到addChildViewController中先保存起来，此时还不会显示出来
    [self addChildViewController:allView];
    [self addChildViewController:videoView];
    [self addChildViewController:voiceView];
    [self addChildViewController:imageView];
    [self addChildViewController:wordView];
}

#pragma mark - <UIScrollViewDelegate>

//等滚动动画完了之后,添加子控制器的view
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //索引
    NSInteger index = scrollView.contentOffset.x /scrollView.width;
    
    //取出子控制器,添加到指定偏移位置
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//默认不设置y值，则y＝20，整个tableview会向下跑20的位置，要手动设置
    vc.view.height = scrollView.height;//设置高度，否则末尾处会空出20的空白
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
