//
//  YZBLoginTextField.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/27.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBLoginTextField.h"
#import <objc/runtime.h>

static NSString * const YZBPlaceHoaderColorPath = @"_placeholderLabel.textColor";

@implementation YZBLoginTextField

/**
 *运行时(runtime)操作
 1、访问一些隐藏底层操作
 **/
////查找所有成员变量看看有没有可以操纵的成员变量
//+ (void)initialize
//{
//    unsigned int count = 0;
//    
//    //此处用的是copy语法，后面需要自行释放
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        NSLog(@"%s", ivar_getName(ivars[i]));
//    }
//    
//    //释放
//    free(ivars);
//}

//取出成员变量_placeholderLabel进行操纵
- (void)awakeFromNib
{
    //两种办法
//    UILabel *label = [self valueForKey:@"_placeholderLabel"];
//    label.textColor = [UIColor blackColor];
    self.tintColor = [UIColor redColor];
    
    //不成为第一响应者
    [self resignFirstResponder];
}

//成为第一响应者
- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor redColor] forKeyPath:YZBPlaceHoaderColorPath];
    return  [super becomeFirstResponder];
}

//撤销第一响应者
-(BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:YZBPlaceHoaderColorPath];
    return [super resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//第一种办法drawPlaceholderInRect，但是不能改变取消选中的颜色状态
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 5, rect.size.width, rect.size.height)
//                  withAttributes:@{
//                                    NSForegroundColorAttributeName: [UIColor grayColor],
//                                    NSFontAttributeName: self.font
//                                }];
//}

//第三种办法，setHighlighted，但是同样不能改变取消选中的状态
//- (void)setHighlighted:(BOOL)highlighted
//{
//    [super setHighlighted:highlighted];
//    [self setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
//    NSLog(@"XXX");
//}
@end
