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

@interface YZBReconmendViewController () <UITableViewDataSource, UITableViewDelegate>

//左边的类别数据
@property (nonatomic, strong) NSArray *categories;

//左边的类别表格
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;

//右边的标签详情页
@property (strong, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation YZBReconmendViewController

static NSString * const YZBCategoryId = @"category";
static NSString * const YZBUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    //显示加载指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    //发送数据请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        //将字典数组转化为对象数组
        self.categories = [YZBReconmendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //必须调用reloadData方法，表的数据才会重新载入并显示，否则还是空白的表
        [self.categoryTableView reloadData];
        
        //设置默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
}

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
    YZBReconmendCategory *cell = self.categories[indexPath.row];
    
    //如果这个数据模型里面已经存储了数组，则不要重复加载
    if (cell.users.count) {
        //直接刷新数据即可，tableview的数据源协议方法会自动调用cellForRowAtIndexPath和numberOfRowsInSection方法，自动取检索出数据
        [self.userTableView reloadData];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = cell.id;
        
        //发送请求给服务器，加载右侧数据
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //防止重复加载所做的处理，将新数据存储到cell中的模型数组的数组
            NSArray *users = [YZBReconmendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [cell.users addObjectsFromArray:users];
            
            //刷新右边表格
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }
}

@end
