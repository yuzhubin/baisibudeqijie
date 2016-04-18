//
//  YZBTopicPictureView.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/17.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBTopicPictureView.h"
#import <UIImageView+WebCache.h>

@interface YZBTopicPictureView ()
//图片
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
//gif标志
@property (strong, nonatomic) IBOutlet UIImageView *gifView;
//查看大图按钮
@property (strong, nonatomic) IBOutlet UIButton *seeBigBtn;

@end

@implementation YZBTopicPictureView

+(instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    //关闭autoresizingMask防止图片显示变形
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setTopic:(YZBTopic *)topic
{
    _topic = topic;
    
    //设置图片内容
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //1、判断是否为gif图片
    //拿到扩展名
    NSString *extension = topic.large_image.pathExtension;
    
    //现转换成小写的再判断
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    //另一种判断方式，在不知道图片的扩展名的情况下,取出图片的的第一个字节，就能知道图片的真实类型
    
    //2、判断是否显示点击查看按钮
    self.seeBigBtn.hidden = !topic.isBigPicture;
    
    if (topic.isBigPicture) {
        self.seeBigBtn.hidden = NO;
        //并更改图片的显示模式，使长图只显示上面一部分,并且在picture的xib的imageview点选裁剪功能
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigBtn.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
