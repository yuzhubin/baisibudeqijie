//
//  YZBTopic.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/9.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBTopic.h"

@implementation YZBTopic

//将时间比较放到get方法中进行计算更为合理
- (NSString *)create_time
{
    //设置日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createTime = [fmt dateFromString:_create_time];
    
    if (createTime.isThisYear) {
        if (createTime.isYestoday) {
            //算出时间差距
            NSDateComponents *cmps = [[NSDate date] deltaFrom:createTime];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }else if(cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if(createTime.isYestoday) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createTime];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createTime];
        }
    }else{
        return _create_time;
    }
}

@end
