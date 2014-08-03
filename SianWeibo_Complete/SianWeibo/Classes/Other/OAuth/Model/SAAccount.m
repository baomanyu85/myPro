//
//  SAAccount.m
//  SianWeibo
//
//  Created by yusian on 14-4-15.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAAccount.h"

@implementation SAAccount

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.accessToken = dict[@"access_token"];
        self.expiresIn = dict[@"expires_in"];
        self.remindIn = dict[@"remind_in"];
        self.uid = dict[@"uid"];
    }
    return self;
}

+ (id)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_accessToken forKey:@"accessToken"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

@end
