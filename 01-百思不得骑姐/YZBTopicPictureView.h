//
//  YZBTopicPictureView.h
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/17.
//  Copyright © 2016年 Yo. All rights reserved.
//  图片帖子中间的图片内容

#import <UIKit/UIKit.h>
#import "YZBTopic.h"

@interface YZBTopicPictureView : UIView

+(instancetype)pictureView;

@property (nonatomic, strong) YZBTopic *topic;

@end
