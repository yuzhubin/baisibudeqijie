//
//  YZBTopicCell.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/10.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBTopicCell.h"
#import <UIImageView+WebCache.h>

@interface YZBTopicCell()

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (strong, nonatomic) IBOutlet UIButton *dingButton;
@property (strong, nonatomic) IBOutlet UIButton *caiButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;

@property (strong, nonatomic) IBOutlet UIImageView *jiavImageView;

@property (strong, nonatomic) IBOutlet UILabel *myTextLabel;

@end

@implementation YZBTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImageView *view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = view;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

 -(void)setTopic:(YZBTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.jiavImageView.hidden = !topic.isJiaV;
    self.nameLabel.text = topic.name;
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    //设置底部状态栏标题文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    //设置帖子文字内容
    self.myTextLabel.text = topic.text;
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    NSString *title = nil;
    
    if (count == 0) {
        title = placeholder;
    }else if(count > 10000) {
        title = [NSString stringWithFormat:@"%.1f万", count/10000.0];
    }else{
        title = [NSString stringWithFormat:@"%zd", count];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = YZBTopicCellMargin;
    frame.size.width -= 2*YZBTopicCellMargin;
    frame.size.height -= YZBTopicCellMargin;
    frame.origin.y += YZBTopicCellMargin;
    
    [super setFrame:frame];
}

@end
