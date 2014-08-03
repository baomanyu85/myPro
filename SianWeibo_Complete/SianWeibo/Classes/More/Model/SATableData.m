//
//  SATableData.m
//  SianWeibo
//
//  Created by yusian on 14-4-14.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  数据模型

#import "SATableData.h"

@implementation SATableData

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
        self.row = [dict[@"row"] integerValue];
    }
    return self;
}

+ (id)tableDateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
