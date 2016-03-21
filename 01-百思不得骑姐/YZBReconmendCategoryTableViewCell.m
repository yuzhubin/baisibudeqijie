//
//  YZBReconmendCategoryTableViewCell.m
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/3/20.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import "YZBReconmendCategoryTableViewCell.h"
#import "YZBReconmendCategory.h"

//此处的@interface是作为.h头文件声明的补充，并且里面的变量定义只有在本文件可见
@interface YZBReconmendCategoryTableViewCell()

//选中时显示的指示器
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation YZBReconmendCategoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = YZBRGBColor(244, 244, 244);
    
    //设置文字颜色
    self.textLabel.textColor = YZBRGBColor(78, 78, 78);
    self.textLabel.highlightedTextColor = YZBRGBColor(219, 21, 26);
    
    //选中时产生一个view，以达到标签被选中时，背景色不变成灰色的效果
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    //当selected这个值等于1时，即这个cell被选中，则设置块的颜色
    if (1 == selected) {
        self.selectedIndicator.backgroundColor = YZBRGBColor(219, 21, 26);
    }
}

- (void)setCategory:(YZBReconmendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
 
    //设置文字高度，防止遮住白色分割线的view,白色分割线是通过在本view的xib文件中添加一个view实现的，同时要在tableview的属性中，把seperator属性设置为none，去掉默认分割线
    self.textLabel.y = 10;
    self.textLabel.height = self.contentView.height - self.textLabel.y*2;
}

@end
