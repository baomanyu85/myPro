//
//  SATableViewCell.h
//  SianWeibo
//
//  Created by yusian on 14-4-14.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Cell视图类

#import <UIKit/UIKit.h>

typedef enum {
    kCellTypeNone,
    kCellTypeArrow,
    kCellTypeLabel,
    kCellTypeSwitch,
    kCellRedButton
} CellType;

@interface SATableViewCell : UITableViewCell

@property (nonatomic, readonly) UILabel     *accessoryLabel;
@property (nonatomic, assign) CellType      cellType;
@property (nonatomic, strong) UISwitch      *accessorySwitch;

- (void)setGroupCellStyleWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
