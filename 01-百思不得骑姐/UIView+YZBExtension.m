//
//  UIView+YZBExtension.m
//  01-百思不得骑姐
//
//  Created by 余铸斌 on 16/3/19.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "UIView+YZBExtension.h"

@implementation UIView (YZBExtension)

//set方法

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;

}

//get方法

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

@end
