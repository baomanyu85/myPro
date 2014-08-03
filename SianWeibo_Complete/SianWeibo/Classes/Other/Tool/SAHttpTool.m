//
//  SAHttpTool.m
//  SianWeibo
//
//  Created by yusian on 14-4-15.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAHttpTool.h"
#import "AFNetWorking.h"
#import "SAAccountTool.h"

@implementation SAHttpTool

// 包装第三方框架AFNetWorking，对外提供类似方法
+ (void)httpToolPostWithBaseURL:(NSString *)urlString path:(NSString *)pathString params:(NSDictionary *)params success:(Success)success failure:(Failure)failure method:(NSString *)method
{
    // 获取授权
    // 1、创建一个Operation
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
    
    
    NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    SAAccountTool *accountTool = [[SAAccountTool alloc] init];
    
    // 如果本在沙盒存在AccessToken则自动将AccessToken加入Request请求中
    if (accountTool.account.accessToken) {
    
        [paramsDict setObject:accountTool.account.accessToken forKey:@"access_token"];
        
    }
    
    NSURLRequest *post = [client requestWithMethod:method path:pathString parameters:paramsDict];
    
    // 2、发送Operation请求
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:post
                                    
        success:
        ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            success(JSON);      // 将方法中的实参传给内部的Success Block调用
        }
                                    
        failure:
        ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            
            failure(error);     // 将方法中的error传给内部的Failure Block调用
        }];
    
    [json start];
}

@end
