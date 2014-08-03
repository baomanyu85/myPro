//
//  SAStatusTool.m
//  SianWeibo
//
//  Created by yusian on 14-4-16.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  微博工具类

#import "SAStatusTool.h"
#import "SAStatus.h"
#import "SAReports.h"
#import "SAComments.h"
#import "UIImageView+WebCache.h"
#import "SAHttpTool.h"

@implementation SAStatusTool

#pragma mark 1、微博数据请求方法
+ (void)statusToolGetStatusWithSinceID:(long long)since maxID:(long long)max Success:(StatusSuccess)success failurs:(StatusFailurs)failure
{
    // 调用SAHttpTool这个工具类，发送相关请求返回数组内容
    [SAHttpTool httpToolPostWithBaseURL:kBaseURL path:@"2/statuses/home_timeline.json" params:
     @{
       @"since_id"  : @(since),
       @"max_id"    : @(max)
       } success:^(id JSON) {
         
         // 如果方法调用没有实现success部分，则方法直接返回
         if (success == nil) return;
         
         // 1、将返回的JSON转换成微博模型并保存到数组
         NSMutableArray *statuses = [NSMutableArray array];
         for (NSDictionary *dict in JSON[@"statuses"]) {
             
             // 将JSON中解析的数据保存到数据模型中
             SAStatus *status = [SAStatus statusWithDict:dict];
             [statuses addObject:status];
         }
         
         // 2、将数组返回给Block形参供方法调用者使用
         success(statuses);
         
     } failure:^(NSError *error) {
         
         if (failure == nil) return;
         
         failure(error);
         
     } method:@"GET"];
    
}

#pragma mark 2、微博评论详情请求方法
+ (void)statusToolGetCommentsWithStatusID:(long long)statusID sinceID:(long long)since maxID:(long long)max Success:(CommentsSuccess)success failurs:(CommentsFailurs)failure
{
    // 调用SAHttpTool这个工具类，发送相关请求返回数组内容
    [SAHttpTool httpToolPostWithBaseURL:kBaseURL path:@"2/comments/show.json" params:
     @{
       @"id"        : @(statusID),
       @"since_id"  : @(since),
       @"max_id"    : @(max)
       } success:^(id JSON) {
           
           NSMutableArray *commentsArray = [NSMutableArray array];                  // 数据模型数组
           
           for (NSDictionary *dict in JSON[@"comments"]) {
               SAComments *comments = [SAComments commentsWithDict:dict];
               [commentsArray addObject:comments];
           }
           
           NSUInteger totalNumber = [JSON[@"total_number"] unsignedIntegerValue];   // 数据总数
           
           long long nextCursor = [JSON[@"next_cursor"] longLongValue];             // 下一条数据ID
           
           success(commentsArray, totalNumber, nextCursor);
           
       } failure:^(NSError *error) {
           
           if (failure == nil) return;
           
           failure(error);
           
       } method:@"GET"];
}

#pragma mark 3、微博转发详情请求方法
+ (void)statusToolGetReportsWithStatusID:(long long)statusID sinceID:(long long)since maxID:(long long)max Success:(ReportsSuccess)success failurs:(ReportsFailurs)failure
{
    // 调用SAHttpTool这个工具类，发送相关请求返回数组内容
    [SAHttpTool httpToolPostWithBaseURL:kBaseURL path:@"2/statuses/repost_timeline.json" params:
     @{
       @"id"        : @(statusID),
       @"since_id"  : @(since),
       @"max_id"    : @(max)
       } success:^(id JSON) {
           
           // 如果方法调用没有实现success部分，则方法直接返回
           if (success == nil) return;
           
           // 1、将返回的JSON转换成微博模型并保存到数组
           NSMutableArray *reportsArray = [NSMutableArray array];                   // 数据模型数组
           
           for (NSDictionary *dict in JSON[@"reposts"]) {
               SAReports *report = [SAReports reportsWithDict:dict];
               [reportsArray addObject:report];
           }
           
           NSUInteger totalNumber = [JSON[@"total_number"] unsignedIntegerValue];   // 数据总数
           
           long long nextCursor = [JSON[@"next_cursor"] longLongValue];             // 下一条数据ID
           
           // 2、将数组返回给Block形参供方法调用者使用
           success(reportsArray, totalNumber, nextCursor);
           
       } failure:^(NSError *error) {
           
           if (failure == nil) return;
           
           failure(error);
           
       } method:@"GET"];
}

#pragma mark 4、请求单条微博详情
+ (void)statusTOolGetSingleStatusWithStatusID:(long long)statusID Success:(SingleStatusSuccess)success failurs:(SingleStatusFailurs)failure
{
    [SAHttpTool httpToolPostWithBaseURL:kBaseURL path:@"2/statuses/show.json" params:
     @{
       
       @"id"    : @(statusID)
       
       } success:^(id JSON) {
         
           if (success == nil) return;
           
           // 将返回的JSON转换成微博模型保存到SAStatus变量中
           SAStatus *status = [[SAStatus alloc] initWithDict:JSON];
           
           // 将数据模型返回给Block形参供方法调用者使用
           success(status);
           
     } failure:^(NSError *error) {
         
         if (failure == nil) return;
         
         failure(error);
         
     } method:@"GET"];
}

#pragma mark 5、微博发送请求
+ (void)statusToolSendStatus:(NSString *)statusText
{
    [SAHttpTool httpToolPostWithBaseURL:kBaseURL path:@"2/statuses/update.json" params:
     @{
       
       @"status"    :statusText
       
       } success:^(id JSON) {
        
    } failure:^(NSError *error) {
        
    } method:@"POST"];
}

#pragma mark 5、获取我的微博内容
+ (void)statusToolGetMyStatusWithSinceID:(long long)since maxID:(long long)max Success:(StatusSuccess)success failurs:(StatusFailurs)failure
{
    // 调用SAHttpTool这个工具类，发送相关请求返回数组内容
    [SAHttpTool httpToolPostWithBaseURL:kBaseURL path:@"2/statuses/user_timeline.json" params:
     @{
       @"since_id"  : @(since),
       @"max_id"    : @(max)
       
       } success:^(id JSON) {
           
           // 如果方法调用没有实现success部分，则方法直接返回
           if (success == nil) return;
           
           // 1、将返回的JSON转换成微博模型并保存到数组
           NSMutableArray *statuses = [NSMutableArray array];
           for (NSDictionary *dict in JSON[@"statuses"]) {
               
               // 将JSON中解析的数据保存到数据模型中
               SAStatus *status = [SAStatus statusWithDict:dict];
               [statuses addObject:status];
           }
           
           // 2、将数组返回给Block形参供方法调用者使用
           success(statuses);
           
       } failure:^(NSError *error) {
           
           if (failure == nil) return;
           
           failure(error);
           
       } method:@"GET"];
}

#pragma mark 6、图片下载方法
// 图片缓存下载方法
+ (void)statusToolInsteadView:(UIImageView *)imageView setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)image
{
    [imageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:image options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

@end
