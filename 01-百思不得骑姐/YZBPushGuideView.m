//
//  YZBPushGuideView.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/31.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBPushGuideView.h"

@implementation YZBPushGuideView

//增加这个属性作为类的主要bundle
+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)closeButton {
    [self removeFromSuperview];
}

@end
