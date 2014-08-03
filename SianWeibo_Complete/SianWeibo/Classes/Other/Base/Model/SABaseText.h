//
//  SABaseText.h
//  SianWeibo
//
//  Created by yusian on 14-4-25.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  数据模型根父类

#import <Foundation/Foundation.h>
#import "SAUser.h"

@interface SABaseText : NSObject

@property (nonatomic, assign)   long long       ID;                 // 微博ID
@property (nonatomic, copy)     NSString        *text;              // 正文
@property (nonatomic, strong)   SAUser          *user;              // 用户
@property (nonatomic, copy)     NSString        *createdAt;         // 创建时间
@property (nonatomic, copy)     NSString        *source;            // 来源

- (id)initWithDict:(NSDictionary *)dict;

@end
