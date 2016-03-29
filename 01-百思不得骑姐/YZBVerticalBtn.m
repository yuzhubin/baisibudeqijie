//
//  YZBVerticalBtn.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/27.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBVerticalBtn.h"

@implementation YZBVerticalBtn

//需要重新布局button，所以自定义
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
