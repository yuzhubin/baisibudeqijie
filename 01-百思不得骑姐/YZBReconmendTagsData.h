//
//  YZBReconmendTagsData.h
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/26.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZBReconmendTagsData : NSObject

/** 图片 **/
@property (nonatomic, copy) NSString *image_list;

/** 名称 **/
@property (nonatomic, copy) NSString *theme_name;

/** 订阅数 **/
@property (nonatomic, assign) NSInteger sub_number;


@end
