//
//  YZBWordViewController.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/2.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBWordViewController.h"
#import "YZBTopic.h"
#import "YZBTopicCell.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>

@interface YZBWordViewController ()

//段子数据
@property (nonatomic, strong) NSMutableArray *topics;

//当前页码
@property (nonatomic, assign) NSInteger currentPage;

//根据服务器要求，当加载下一页数据需要的参数
@property (nonatomic, copy) NSString *maxtime;

//上一次请求的参数
@property (nonatomic,strong) NSMutableDictionary *params;

@end

@implementation YZBWordViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString * const YZBTopicCellId = @"topic";

#pragma mark - 处理刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

//初始化tableview
- (void)setupTableView
{
    //指定内部内容布局的起点(必须要在这里设置，否则tableview的内容不能穿透)
    CGFloat bottomInsert = self.tabBarController.tabBar.height;
    CGFloat topInsert = YZBTitlesViewH + YZBTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(topInsert, 0, bottomInsert, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset; //指定tableview滚动条的那边距，是指不会被一部分的状态栏覆盖
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBTopicCell class]) bundle:nil] forCellReuseIdentifier:YZBTopicCellId];
}

#pragma mark - 数据处理
//加载第一页帖子数据
-(void)loadNewTopics
{
    //先结束上拉加载新数据防止冲突
    [self.tableView.mj_footer endRefreshing];
    
    //发送数据参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        //发现最后一次请求根本次请求不一样，则不去处理
        if (self.params != params) {
            return;
        }
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [YZBTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        self.currentPage = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return;
        }
        
        [self.tableView.mj_header endRefreshing];
    }];
}

//加载更多的帖子数据
-(void)loadMoreTopics
{
    //先结束下拉刷新数据防止冲突
    [self.tableView.mj_header endRefreshing];
    
    self.currentPage++;
    
    //发送数据参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"page"] = @(self.currentPage);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if (self.params != params) {
            return;
        }
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *newTopics = [YZBTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return;
        }
        
        [self.tableView.mj_footer endRefreshing];
        //回复页码
        self.currentPage--;
    }];
}

#pragma mark - Tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZBTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:YZBTopicCellId];
    
    if (nil == cell) {
        cell = [[YZBTopicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:YZBTopicCellId];
    }
    
    //加载数据
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - Tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  200;
}


@end
