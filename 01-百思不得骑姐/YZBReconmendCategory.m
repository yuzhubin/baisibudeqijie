//
//  YZBReconmendCategory.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/20.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBReconmendCategory.h"

@implementation YZBReconmendCategory

- (NSMutableArray *)users
{
    //返回空数组
    if(!_users){
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end
