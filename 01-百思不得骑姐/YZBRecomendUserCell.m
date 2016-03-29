//
//  YZBRecomendUserCell.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/23.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBRecomendUserCell.h"
#import "YZBReconmendUser.h"
#import <UIImageView+WebCache.h>

@interface YZBRecomendUserCell()

@property (strong, nonatomic) IBOutlet UIImageView *HeaderImageView;
@property (strong, nonatomic) IBOutlet UILabel *ScreenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *FansCountLabel;

@end


@implementation YZBRecomendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(YZBReconmendUser *)user
{
    _user = user;
    
    self.ScreenNameLabel.text = user.screen_name;
    
    NSString *fans_count = nil;
    if (user.fans_count < 10000) {
        fans_count = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    }else{
        fans_count = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count/10000.0];
    }
    
    self.FansCountLabel.text = fans_count;
    
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
