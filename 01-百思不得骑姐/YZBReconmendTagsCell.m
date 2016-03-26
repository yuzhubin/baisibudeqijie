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
    self.subNumber.text = [NSString stringWithFormat:@"%ld", (long)reconmendTag.sub_number];
}

@end
