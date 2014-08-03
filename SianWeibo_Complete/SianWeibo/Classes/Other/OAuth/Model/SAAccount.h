//
//  SAAccount.h
//  SianWeibo
//
//  Created by yusian on 14-4-15.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString    *accessToken;
@property (nonatomic, copy) NSString    *expiresIn;
@property (nonatomic, copy) NSString    *remindIn;
@property (nonatomic, copy) NSString    *uid;

- (id)initWithDict:(NSDictionary *)dict;

+ (id)accountWithDict:(NSDictionary *)dict;

@end
