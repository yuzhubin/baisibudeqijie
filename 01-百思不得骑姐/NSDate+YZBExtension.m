//
//  NSDate+YZBExtension.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/10.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "NSDate+YZBExtension.h"

@implementation NSDate (YZBExtension)

//比较from和self的时间差值
- (NSDateComponents *)deltaFrom:(NSDate *)from {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |
                             NSCalendarUnitSecond fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];

    return year == selfYear;
}

- (BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];

    return (nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day);
}

- (BOOL)isYestoday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    return (nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && (nowCmps.day - selfCmps.day) == 1);
}

@end
