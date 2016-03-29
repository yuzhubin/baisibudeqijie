//
//  YZBReconmendTagsCell.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/26.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBReconmendTagsCell.h"
#import "YZBReconmendTagsData.h"
#import <UIImageView+WebCache.h>

@interface YZBReconmendTagsCell()

@property (strong, nonatomic) IBOutlet UIImageView *imageList;
@property (strong, nonatomic) IBOutlet UILabel *themeName;
@property (strong, nonatomic) IBOutlet UILabel *subNumber;

@end

@implementation YZBReconmendTagsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReconmendTag:(YZBReconmendTagsData *)reconmendTag
{
    _reconmendTag = reconmendTag;
    [self.imageList sd_setImageWithURL:[NSURL URLWithString:reconmendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeName.text = reconmendTag.theme_name;
    
    NSString *subNumber = nil;
    
    //增加对用户过万的处理ß
    if (reconmendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%ld人订阅", (long)reconmendTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", (long)reconmendTag.sub_number/10000.0];
    }
    
    self.subNumber.text = subNumber;
}

//重写setFrame实现cell边框的控制，如果从外部更改frame，则到这里还会被重置
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2*frame.origin.x;
    frame.size.height -= 1;

    [super setFrame:frame];
}

@end
