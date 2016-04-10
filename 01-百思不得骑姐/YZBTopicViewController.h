//
//  YZBTopicViewController.h
//  百思不得骑姐
//
//  Created by 余铸斌 on 16/4/10.
//  Copyright © 2016年 Yo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YZBTopicTypeAll = 1,
    YZBTopicTypeVideo = 41,
    YZBTopicTypeVoice = 31,
    YZBTopicTypeImage = 10,
    YZBTopicTypeWord = 29,
}YZBTopicType;

@interface YZBTopicViewController : UITableViewController

@property (nonatomic, assign) YZBTopicType type;

@end
