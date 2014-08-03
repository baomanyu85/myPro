//
//  SAUser.h
//  SianWeibo
//
//  Created by yusian on 14-4-16.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  用户数据模型

#import <Foundation/Foundation.h>

#pragma mark - 1、自定义数据类型
#pragma mark 1.1、用户认证类型
typedef enum {
    kVerifiedTypeNone           = -1,   // 无认证
    kVerifiedTypePersonal       = 0,    // 个人认证
    kVerifiedTypeOrgEnterprice  = 2,    // 企业认证
    kVerifiedTypeOrgMedia       = 3,    // 媒体认证
    kVerifiedTypeOrgWebsite     = 5,    // 网站认证
    kVerifiedTypeDaren          = 220   // 微博达人
}VerifiedType;

#pragma mark 1.2、会员类型
typedef enum {
    kMbTypeNone,                        // 非会员
    kMbTypeNormal,                      // 普通会员
    kMbTypeYear                         // 年费会员
}MbType;

@interface SAUser : NSObject

@property (nonatomic, copy)     NSString        *screenName;        // 昵称
@property (nonatomic, copy)     NSString        *profileImageUrl;   // 头像
@property (nonatomic, assign)   BOOL            verified;           // 是否验证
@property (nonatomic, assign)   VerifiedType    verifiedType;       // 验证类型
@property (nonatomic, assign)   NSInteger       mbrank;             // 会员等级
@property (nonatomic, assign)   MbType          mbtype;             // 会员类型

- (id)initWithDict:(NSDictionary *)dict;

+ (id)statusUserWithDict:(NSDictionary *)dict;

@end
