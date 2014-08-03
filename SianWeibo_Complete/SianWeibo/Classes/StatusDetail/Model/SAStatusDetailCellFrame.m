//
//  SAStatusDetailFrame.m
//  SianWeibo
//
//  Created by yusian on 14-4-23.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAStatusDetailCellFrame.h"

@implementation SAStatusDetailCellFrame

#pragma mark 设置数据模型
-(void)setDataModel:(SAStatus *)dataModel
{
    [super setDataModel:dataModel];
    
    // 在父类视图的基础上，如果有转发，则将转发体高度增加一个Dock高度，并将Cell总高度也增加一个Dock高度
    if (dataModel.retweetedStatus){
        
        _retweet.size.height += kDetailReDockH + kInterval;
        
        self.cellHeight += kDetailReDockH + kInterval;
    }
}

@end
