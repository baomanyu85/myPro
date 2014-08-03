//
//  SAHomeStatusCell.m
//  SianWeibo
//
//  Created by yusian on 14-4-18.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  微博单元格类

#import "SAHomeStatusCell.h"
#import "SAStatusDock.h"

@interface SAHomeStatusCell ()
{
    SAStatusDock    *_statusDock;   // 功能菜单
}
@end

@implementation SAHomeStatusCell

#pragma mark 1、初始化Cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 1、添加功能菜单
        _statusDock = [[SAStatusDock alloc] init];
        [self.contentView addSubview:_statusDock];
    }
    return self;
}


#pragma mark - 2、设置Cell内容
-(void)setCellFrame:(SAHomeStatusCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    // 1、设置功能菜单栏内容
    _statusDock.status = cellFrame.dataModel;
    
}


#pragma mark - 3、设置Cell标识
+ (NSString *)ID
{
    return @"HomeStatusCell";
}

@end
