//
//  YZBReconmendViewController.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/20.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBReconmendViewController.h"
#import "YZBReconmendCategoryTableViewCell.h"
#import "YZBReconmendCategory.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface YZBReconmendViewController () <UITableViewDataSource, UITableViewDelegate>

//左边的类别数据
@property (nonatomic, strong) NSArray *categories;

//左边的类别表格
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation YZBReconmendViewController

static NSString * const YZBCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBReconmendCategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"category"];
    
    self.navigationItem.title = @"推荐关注";
    
    self.view.backgroundColor = YZBBackGroundColor;
    
    //清除tableview多余的行
    self.categoryTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //显示加载指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZBReconmendCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YZBCategoryId];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZBReconmendCategory *cell = self.categories[indexPath.row];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = cell.id;
    
    //发送请求给服务器，加载右侧数据
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject[@"list"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
