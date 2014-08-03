//
//  SACommentCell.h
//  SianWeibo
//
//  Created by yusian on 14-4-26.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SABaseTextCell.h"
#import "SACommentCellFrame.h"

@interface SACommentCell : SABaseTextCell

@property (nonatomic, strong) SACommentCellFrame *cellFrame;

- (void)setGroupCellStyleWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
