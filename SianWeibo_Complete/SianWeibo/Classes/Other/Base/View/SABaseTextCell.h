//
//  SABaseTextCell.h
//  SianWeibo
//
//  Created by yusian on 14-4-25.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Cell根父类

#import <UIKit/UIKit.h>
@class SABaseTextCellFrame;

@interface SABaseTextCell : UITableViewCell

@property (nonatomic, strong) SABaseTextCellFrame *cellFrame;

+ (NSString *)ID;

@end
