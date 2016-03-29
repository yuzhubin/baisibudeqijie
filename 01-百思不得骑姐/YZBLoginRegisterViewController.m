//
//  YZBLoginRegisterViewController.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/27.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBLoginRegisterViewController.h"
#import "YZBVerticalBtn.h"

@interface YZBLoginRegisterViewController ()

@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *secretCode;

@end

@implementation YZBLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = YZBBackGroundColor;
    
    //文字属性
    //NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    //attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //属性文本(富文本技术)
    //NSMutableAttributedString *placeHoader = [[NSMutableAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    
    //测试分别设置每个文字的大小，颜色(富文本技术)
//    NSMutableAttributedString *placeHoader = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//    [placeHoader setAttributes:@{
//                                 NSForegroundColorAttributeName: [UIColor yellowColor],
//                                 //NSFontAttributeName: [UIFont systemFontOfSize:30]
//                                 } range:NSMakeRange(0, 1)];
//    [placeHoader setAttributes:@{
//                                 NSForegroundColorAttributeName: [UIColor greenColor],
//                                 //NSFontAttributeName: [UIFont systemFontOfSize:30]
//                                 } range:NSMakeRange(1, 1)];
//    [placeHoader setAttributes:@{
//                                 NSForegroundColorAttributeName: [UIColor redColor],
//                                 //NSFontAttributeName: [UIFont systemFontOfSize:30]
//                                 } range:NSMakeRange(2, 1)];

    
    //self.phoneNumber.attributedPlaceholder = placeHoader;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//让状态栏显示亮色，以免被深色背景图覆盖
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)loginClick:(id)sender {
    NSLog(@"login");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
