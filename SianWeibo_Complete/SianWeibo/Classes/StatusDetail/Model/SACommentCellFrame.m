//
//  SACommentCellFrame.m
//  SianWeibo
//
//  Created by yusian on 14-4-26.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SACommentCellFrame.h"

@implementation SACommentCellFrame

-(void)setDataModel:(SAComments *)dataModel
{
    [super setDataModel:dataModel];
    
    // 1、正文
    CGFloat textX = self.screenNameRect.origin.x;
    CGFloat textY = CGRectGetMaxY(self.screenNameRect);
    CGFloat textWidth = self.cellWidth - self.avataRect.size.width - 3 * kInterval;
    CGSize  textSize = [dataModel.text sizeWithFont:kTextFount constrainedToSize:CGSizeMake(textWidth, MAXFLOAT)];
    self.textRect = (CGRect){{textX, textY}, textSize};
    
    // 2、时间
    CGFloat timeX = textX;
    CGFloat timeY = CGRectGetMaxY(self.textRect) + kInterval;
    CGSize timeSize = [dataModel.createdAt sizeWithFont:kTimeFont];
    self.timeRect = (CGRect){{timeX, timeY}, timeSize};
    
    self.cellHeight = CGRectGetMaxY(self.timeRect) + kCellMargins + kInterval;
}

@end
