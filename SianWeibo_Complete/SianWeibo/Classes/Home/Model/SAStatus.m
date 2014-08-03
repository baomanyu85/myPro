//
//  SAStatus.m
//  SianWeibo
//
//  Created by yusian on 14-4-16.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  微博数据模型

#import "SAStatus.h"

@implementation SAStatus

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        
        self.repostsCount   = [dict[@"reposts_count"] intValue];        // 转发数
        self.commentsCount  = [dict[@"comments_count"] intValue];       // 评论数
        self.attitudesCount = [dict[@"attitudes_count"] intValue];      // 点赞数
        self.picUrls        = dict[@"pic_urls"];                        // 配图
        
        NSDictionary *retweetedStatus = dict[@"retweeted_status"];
        if (retweetedStatus) {                                          // 转发体(被转载的微博内容)
            
            self.retweetedStatus = [[SAStatus alloc] initWithDict:retweetedStatus];
            
        }
    }
    return self;
}

+ (id)statusWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
