//
//  UIView+YZBExtension.h
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import <UIKit/UIKit.h>

//为了方便地使用实例的size属性，直接讲其属性做一个扩展分类文件PrefixHeader，在扩展文件中包含本头文件，并且在工程build setting选项的Prefix Header中指定这个pch文件的路径,这样整个工程的所有文件都可以调用这个@property了
@interface UIView (YZBExtension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
