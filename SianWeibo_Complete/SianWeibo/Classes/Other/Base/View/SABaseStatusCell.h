//
//  SABaseStatusCell.h
//  SianWeibo
//
//  Created by yusian on 14-4-23.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  微博类Cell父类

#import "SABaseTextCell.h"
#import "SABaseStatusCellFrame.h"

@interface SABaseStatusCell : SABaseTextCell

@property (nonatomic, strong) SABaseStatusCellFrame *cellFrame;     // 框架模型
@property (nonatomic, strong) UIImageView           *retweet;       // 转发体视图

@end
