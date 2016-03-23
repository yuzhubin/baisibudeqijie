//
//  YZBReconmendUser.h
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/23.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZBReconmendUser : NSObject

/** 头像 **/
@property (nonatomic, copy) NSString *header;

/** 粉丝 **/
@property (nonatomic, assign) NSInteger fans_count;

/** 昵称 **/
@property (nonatomic, copy) NSString *screen_name;

@end
