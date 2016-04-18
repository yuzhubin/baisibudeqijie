//
//  YZBTopic.h
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/9.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import <UIKit/UIKit.h>

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

/** 是否新浪加v **/
@property (nonatomic, assign, getter=isJiaV) BOOL sina_v;

/** 图片的宽度 **/
@property (nonatomic, assign) CGFloat width;

/** 图片的高度 **/
@property (nonatomic, assign) CGFloat height;

/** 图片的路径 **/
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *large_image;
@property (nonatomic, copy) NSString *middle_image;

/** 帖子的类型 **/
@property (nonatomic, assign) YZBTopicType type;

/** 额外的辅助属性 **/
/** cell 的高度 **/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片控件的frame **/
@property (nonatomic, assign, readonly) CGRect pictureFrame;
/** 图片是否为长图 **/
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@end
