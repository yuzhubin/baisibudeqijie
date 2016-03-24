//
//  YZBReconmendCategory.h
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/20.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZBReconmendCategory : NSObject

/** id **/
@property (nonatomic, assign) NSString *id;

/** name **/
@property (nonatomic, copy) NSString *name;

/** count **/
@property (nonatomic, assign) NSInteger count;

/** 这个类别对应的用户数据模型数组 **/
@property (nonatomic, strong) NSMutableArray *users;

@end
