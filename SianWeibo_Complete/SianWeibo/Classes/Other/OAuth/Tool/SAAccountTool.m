//
//  SAAccountTool.m
//  SianWeibo
//
//  Created by yusian on 14-4-15.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAAccountTool.h"
#define kAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0] stringByAppendingString:@"/account.data"]

@implementation SAAccountTool

// 单例创建三个条件
// 1、全局实例
static SAAccountTool *_instance;

// 2、类创建方法
+ (SAAccountTool *)sharedAccountTool
{
    if (_instance) {
        _instance = [[self alloc] init];
    }
    return  [[self alloc] init];
}

// 3、重写alloc方法
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

// 单例在MRC中还需要重写以下三个方法
/******************************
-(oneway void)release
{
    return;
}
-(id)retain
{
    return self;
}
-(NSUInteger)retainCount
{
    return 1;
}
*******************************/

- (id)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFile];
    }
    return self;
}

- (void)saveAccount:(SAAccount *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountFile];
}

@end
