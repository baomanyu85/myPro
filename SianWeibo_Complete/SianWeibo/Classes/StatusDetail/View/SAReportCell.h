//
//  SAReportCell.h
//  SianWeibo
//
//  Created by yusian on 14-4-26.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SABaseTextCell.h"
#import "SAReportCellFrame.h"
@interface SAReportCell : SABaseTextCell

@property (nonatomic, strong) SAReportCellFrame *cellFrame;

- (void)setGroupCellStyleWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
