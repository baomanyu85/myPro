//
//  SAStatusTool.h
//  SianWeibo
//
//  Created by yusian on 14-4-16.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  微博工具类

#import <Foundation/Foundation.h>
@class SAStatus;

/*********************自定义Block区*********************/

// 微博内容请求
typedef void(^StatusSuccess)(NSArray * array);
typedef void(^StatusFailurs)(NSError * error);

// 微博评论详情请求
typedef void(^CommentsSuccess)(NSArray *commentsArray, NSUInteger totalNumber, long long nextCursor);
typedef void(^CommentsFailurs)(NSError * error);

// 微博转发详情请求
typedef void(^ReportsSuccess)(NSArray *reportsArray, NSUInteger totalNumber, long long nextCursor);
typedef void(^ReportsFailurs)(NSError * error);

// 请求单条微博详情
typedef void(^SingleStatusSuccess)(SAStatus *status);
typedef void(^SingleStatusFailurs)(NSError * error);

/******************************************************/

@interface SAStatusTool : NSObject

// 请求微博内容
+ (void)statusToolGetStatusWithSinceID:(long long)since maxID:(long long)max Success:(StatusSuccess)success failurs:(StatusFailurs)failure;

// 请求微博评论内容
+ (void)statusToolGetCommentsWithStatusID:(long long)statusID sinceID:(long long)since maxID:(long long)max Success:(CommentsSuccess)success failurs:(CommentsFailurs)failure;

// 请求微博转发内容
+ (void)statusToolGetReportsWithStatusID:(long long)statusID sinceID:(long long)since maxID:(long long)max Success:(ReportsSuccess)success failurs:(ReportsFailurs)failure;

// 请求单条微博详情
+ (void)statusTOolGetSingleStatusWithStatusID:(long long)statusID Success:(SingleStatusSuccess)success failurs:(SingleStatusFailurs)failure;

// 发送微博请求
+ (void)statusToolSendStatus:(NSString *)statusText;

// 请求我的微博
+ (void)statusToolGetMyStatusWithSinceID:(long long)since maxID:(long long)max Success:(StatusSuccess)success failurs:(StatusFailurs)failure;

// 图片分线程下载
+ (void)statusToolInsteadView:(UIImageView *)imageView setImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)image;

@end
