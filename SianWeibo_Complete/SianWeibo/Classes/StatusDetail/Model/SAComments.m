//
//  SAComments.m
//  SianWeibo
//
//  Created by yusian on 14-4-24.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAComments.h"

@implementation SAComments

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        
        
        
    }
    return self;
}

+ (id)commentsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end

