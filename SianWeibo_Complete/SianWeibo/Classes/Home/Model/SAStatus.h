//
//  SAStatus.h
//  SianWeibo
//
//  Created by yusian on 14-4-16.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  微博数据模型

#import "SABaseText.h"

@interface SAStatus : SABaseText

@property (nonatomic, strong)   SAStatus        *retweetedStatus;   // 转发体
@property (nonatomic, assign)   NSInteger       repostsCount;       // 转发数
@property (nonatomic, assign)   NSInteger       commentsCount;      // 评论数
@property (nonatomic, assign)   NSInteger       attitudesCount;     // 点赞数
@property (nonatomic, strong)   NSArray         *picUrls;           // 配图

+ (id)statusWithDict:(NSDictionary *)dict;

@end
