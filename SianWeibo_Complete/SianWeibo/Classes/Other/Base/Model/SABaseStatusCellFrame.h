//
//  SABaseStatusCellFrame.h
//  SianWeibo
//
//  Created by yusian on 14-4-23.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SABaseTextCellFrame.h"
#import "SAStatus.h"
@interface SABaseStatusCellFrame : SABaseTextCellFrame
{
    CGRect      _retweet;           // 转发体Frame
}

@property (nonatomic, readonly) CGRect      image;          // 配图
@property (nonatomic, readonly) CGRect      retweet;        // 转发体视图
@property (nonatomic, readonly) CGRect      reScreenName;   // 转发体昵称
@property (nonatomic, readonly) CGRect      reText;         // 转发体正文
@property (nonatomic, readonly) CGRect      reImage;        // 转发体配图
@property (nonatomic, strong)   SAStatus    *dataModel;     // 数据模型

@end
