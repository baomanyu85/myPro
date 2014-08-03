//
//  SATableData.h
//  SianWeibo
//
//  Created by yusian on 14-4-14.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  数据模型

#import <Foundation/Foundation.h>

@interface SATableData : NSObject

@property (nonatomic, copy) NSString        *icon;
@property (nonatomic, copy) NSString        *name;
@property (nonatomic, assign) NSInteger     row;

- (id)initWithDict:(NSDictionary *)dict;
+ (id)tableDateWithDict:(NSDictionary *)dict;

@end
