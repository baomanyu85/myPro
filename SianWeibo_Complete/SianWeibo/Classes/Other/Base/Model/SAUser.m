//
//  SAUser.m
//  SianWeibo
//
//  Created by yusian on 14-4-16.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  用户数据模型

#import "SAUser.h"

@implementation SAUser

#pragma mark - 1、对象初始化方法
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.screenName = dict[@"screen_name"];                     // 昵称
        self.profileImageUrl = dict[@"profile_image_url"];          // 头像
        self.verified = [dict[@"verified"] boolValue];              // 是否验证
        self.verifiedType = [dict[@"verified_type"] intValue];      // 验证类型
        self.mbrank = [dict[@"mbrank"] intValue];               // 会员等级
        self.mbtype = [dict[@"mbtype"] intValue];                   // 会员类型
    }
    return self;
}

#pragma mark - 2、类构造方法
+ (id)statusUserWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
