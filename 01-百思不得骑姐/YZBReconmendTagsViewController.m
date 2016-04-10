//
//  YZBReconmendTagsViewController.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/26.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBReconmendTagsViewController.h"
#import "YZBReconmendTagsCell.h"
#import "YZBReconmendTagsData.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface YZBReconmendTagsViewController () <UITableViewDataSource, UITableViewDelegate>

//标签列表
@property (strong, nonatomic) NSArray *tags;

//网络请求控制器，在开头定义好方便统一控制
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end


static NSString * const YZBTagsId = @"tag";

@implementation YZBReconmendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
}

- (void)setupTableView
{
    self.title = @"推荐标签";
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBReconmendTagsCell class]) bundle:nil] forCellReuseIdentifier:YZBTagsId];
    
    //设置cell行高
    self.tableView.rowHeight = 70;
    
    //不要分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = YZBBackGroundColor;
}

- (void)loadTags
{
    //显示加载指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    //填充参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        //使用模型数组
        self.tags = [YZBReconmendTagsData mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZBReconmendTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:YZBTagsId];
    cell.reconmendTag = self.tags[indexPath.row];
    return cell;
}

@end
