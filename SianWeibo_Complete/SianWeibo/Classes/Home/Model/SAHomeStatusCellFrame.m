//
//  SAHomeStatusCellFrame.m
//  SianWeibo
//
//  Created by yusian on 14-4-18.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  数据框架模型

#import "SAHomeStatusCellFrame.h"

@implementation SAHomeStatusCellFrame

-(void)setDataModel:(SAStatus *)dataModel
{
    [super setDataModel:dataModel];
    
    self.cellHeight += kStatusDockHeight;
}

@end
