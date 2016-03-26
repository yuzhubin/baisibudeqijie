//
//  YZBReconmendViewController.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/20.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBReconmendViewController.h"
#import "YZBReconmendCategoryCell.h"
#import "YZBRecomendUserCell.h"

#import "YZBReconmendCategory.h"
#import "YZBReconmendUser.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface YZBReconmendViewController () <UITableViewDataSource, UITableViewDelegate>

//左边的类别数据
@property (nonatomic, strong) NSArray *categories;

//左边的类别表格
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;

//右边的标签详情页
@property (strong, nonatomic) IBOutlet UITableView *userTableView;

//请求数据
@property (strong, nonatomic) NSMutableDictionary *params;

//网络请求控制器，在开头定义好方便统一控制
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation YZBReconmendViewController

static NSString * const YZBCategoryId = @"category";
static NSString * const YZBUserId = @"user";

- (AFURLSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化控件
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧数据
    [self loadCategories];
}

//加载左侧类别
- (void)loadCategories
{
    //显示加载指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    //发送数据请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        //将字典数组转化为对象数组
        self.categories = [YZBReconmendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //必须调用reloadData方法，表的数据才会重新载入并显示，否则还是空白的表
        [self.categoryTableView reloadData];
        
        //设置默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入刷新状态即可
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
}

//初始化控件
- (void)setupTableView
{
    //注册左边类别的cell,categoryTableView这个值为上面定义的本地变量
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBReconmendCategoryCell class]) bundle:nil] forCellReuseIdentifier:@"category"];
    
    //注册右边详情的cell,userTableView这个值为上面定义的本地变量
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBRecomendUserCell class]) bundle:nil] forCellReuseIdentifier:@"user"];
    
    //设置insert,防止顶部详情内容被遮住一些
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    
    self.userTableView.rowHeight = 70;
    
    self.navigationItem.title = @"推荐关注";
    
    self.view.backgroundColor = YZBBackGroundColor;
    
    //清除tableview多余的行
    self.categoryTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

//添加刷新控件
- (void)setupRefresh
{
    //顶部下拉刷新控件
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //底部上拉加载控件
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark - 加载用户数据
//下拉加载新数据
- (void)loadNewUsers
{
    YZBReconmendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.id;
    self.params = params;
    
    //发送请求给服务器，加载右侧数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //清空当前所有用户数据，防止重复加载
        [category.users removeAllObjects];
        
        //一进来就初始化当前页码为1
        category.currentPage = 1;
        
        //重新上拉允许加载
        [self.userTableView.mj_footer beginRefreshing];
        
        //防止重复加载所做的处理，将新数据存储到cell中的模型数组的数组
        NSArray *users = [YZBReconmendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:users];
        
        //获取右侧详情标签的总数
        category.total_page = [responseObject[@"total_page"] integerValue];
        category.total = [responseObject[@"total"] integerValue];
        
        // 如果是上一次请求的结果，则直接忽略，保证只处理当请求
        //允许把数据加到model中，但是不允许刷新当前表格
        if (self.params != params) {
            return;
        }
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        //如果已经全部加载完毕,则一点击显示就提示没有更多数据，不用在去触发刷新再计算
        if (category.total_page == category.currentPage) {
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 如果是上一次请求的结果，则直接忽略
        if (self.params != params) {
            return;
        }
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.mj_header endRefreshing];
    }];
}

//上拉加载更多数据
- (void)loadMoreUsers
{
    //得到当前被选定的类别索引
    YZBReconmendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.id;
    self.params = params;

    //如果总页数还没加载完则继续加载
    if (category.currentPage+1 <= category.total_page && category.users.count < category.total) {
        params[@"page"] = @(++category.currentPage);
        
        //发送请求给服务器，加载右侧数据
        [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //防止重复加载所做的处理，将新数据存储到cell中的模型数组的数组
            NSArray *users = [YZBReconmendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
            [category.users addObjectsFromArray:users];
            
            // 如果是上一次请求的结果，则直接忽略，保证只处理当请求
            if (self.params != params) {
                return;
            }
        
            //刷新右边表格
            [self.userTableView reloadData];
        
            [self.userTableView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
            [self.userTableView.mj_footer endRefreshing];
        }];
    }else{
        // 如果是上一次请求的结果，则直接忽略，保证只处理当请求
        if (self.params != params) {
            return;
        }
        
        category.currentPage = 1;
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDataSource>
//由于下面两个数据源方法为两个tableview公用，所以要根据标示加以区分
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else{
        //先取出左边被选中的类别模型self.categoryTableView.indexPathForSelectedRow.row，即可知道右边user数组所处的位置，继而取出数组
        YZBReconmendCategory *cell = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        
        //每次刷新右边数据时，当这个详情页没有数据时，隐藏上拉的tableview
        self.userTableView.mj_footer.hidden = (cell.users.count == 0);
        
        return cell.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        YZBReconmendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:YZBCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{
        YZBRecomendUserCell *u_cell = [tableView dequeueReusableCellWithIdentifier:YZBUserId];
        YZBReconmendCategory *c_cell = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        u_cell.user = c_cell.users[indexPath.row];
        
        return u_cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先结束上一次的刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    YZBReconmendCategory *category = self.categories[indexPath.row];
    
    //当用户切换到其他页面的时候，先结束刷新操作，不去发送请求
    [self.userTableView.mj_footer  endRefreshing];
    
    //如果这个数据模型里面已经存储了数组，则不要重复加载
    if (category.users.count) {
        //直接刷新数据即可，tableview的数据源协议方法会自动调用cellForRowAtIndexPath和numberOfRowsInSection方法，自动取检索出数据
        [self.userTableView reloadData];
        
        //如果本页数据已经全部加载完，则提示用户，不要在点上拉加载了
        if (category.users.count == category.total) {
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }else{
        //一进来就刷新数据，防止userTableView还停留在上一页的数据
        [self.userTableView reloadData];
        
        //先显示下拉刷新状态，不要直接加载，防止网速慢的时候界面无提示,此时就回直接调用刷新方法loadNewUsers
        [self.userTableView.mj_header beginRefreshing];
    }
}

//当用户关闭这个view时，清空掉当前的所有请求
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}

@end
