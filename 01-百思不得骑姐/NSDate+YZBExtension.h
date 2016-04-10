//
//  NSDate+YZBExtension.h
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/10.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YZBExtension)

//比较时间差值
- (NSDateComponents *)deltaFrom:(NSDate *)from;

//是否为今年
- (BOOL)isThisYear;

//是否是今天
- (BOOL)isToday;

//是否是昨天
- (BOOL)isYestoday;

@end
