//
//  SAHttpTool.h
//  SianWeibo
//
//  Created by yusian on 14-4-15.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(id JSON);
typedef void (^Failure)(NSError *error);

@interface SAHttpTool : NSObject

+ (void)httpToolPostWithBaseURL:(NSString *)urlString path:(NSString *)pathString params:(NSDictionary *)params success:(Success)success failure:(Failure)failure method:(NSString *)method;

@end
