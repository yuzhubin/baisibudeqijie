//
//  YZBTopic.h
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/9.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZBTopic : NSObject

//名称
@property (nonatomic, copy) NSString *name;

//头像
@property (nonatomic, copy) NSString *profile_image;

//创建时间
@property (nonatomic, copy) NSString *create_time;

//段子内容
@property (nonatomic, copy) NSString *text;

/** 顶 **/
@property (nonatomic, assign) NSInteger ding;

/** 踩 **/
@property (nonatomic, assign) NSInteger cai;

/** 转发 **/
@property (nonatomic, assign) NSInteger repost;

/** 评论 **/
@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, assign, getter=isJiaV) BOOL sina_v;

@end
