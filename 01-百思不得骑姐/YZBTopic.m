//
//  YZBTopic.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/9.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBTopic.h"
#import <MJExtension.h>

@implementation YZBTopic
{
    //为了防止_cellHeight被外部修改，设定为private方法
    CGFloat _cellHeight;
    CGRect _pictureFrame;
}

//替换字典中的key
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"};
}

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

- (CGFloat)cellHeight
{
    //保证每个cell高度只计算一遍
    if (_cellHeight == 0) {
        
        //根据文字内容计算高度
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-YZBTopicCellMargin*4, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
        //文字部分高度
        _cellHeight = textH + YZBTopicCellTextY + YZBTopicCellMargin;
        
        //根据段子的类型计算高度
        if (self.type == YZBTopicTypeImage) {
            
            //图片显示出来的高度计算(与原图存在一定的比例)
            CGFloat pictureW = maxSize.width; //显示宽度等于屏幕宽度
            CGFloat pictureH = pictureW*self.height/self.width;//显示高度要进行换算
            
            if (pictureH >= YZBTopicCellPictureMaxH) {
                pictureH = YZBTopicCellPictureMiniH;
                self.bigPicture = YES;
            }
            
            //计算图片控件的frame,保存起来
            _pictureFrame = CGRectMake(YZBTopicCellMargin, YZBTopicCellTextY+textH+YZBTopicCellMargin, pictureW, pictureH);
            
            _cellHeight += pictureH + YZBTopicCellMargin;
        }
        
        //加上底部高度,并且弥补掉剪去的高度
        _cellHeight += YZBTopicCellButtomBarH;
    }
    
    return _cellHeight;
}

@end
