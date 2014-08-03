//
//  SABaseText.m
//  SianWeibo
//
//  Created by yusian on 14-4-25.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  数据模型根父类

#import "SABaseText.h"

@implementation SABaseText

#pragma mark - 1、初始化
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.ID             = [dict[@"id"] longLongValue];                      // 微博ID
        self.text           = dict[@"text"];                                    // 正文
        self.user           = [SAUser statusUserWithDict:dict[@"user"]];        // 用户
        self.createdAt      = dict[@"created_at"];                              // 创建时间
        self.source         = dict[@"source"];                                  // 来源
    }
    return self;
}

#pragma mark - 2、重写set/get方法
#pragma mark 2.1、重写时间get方法格式化输出
-(NSString *)createdAt
{
    // 取出数据结构为: Sat Apr 19 19:15:53 +0800 2014，将数据格式化输出业务数据
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    dfm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 格式取出的字符串，获取时间对象
    NSDate *createdTime = [dfm dateFromString:_createdAt];
    dfm.dateFormat = @"M月d日 HH点mm分";
    
    // 时间格式化成字符串
    NSString *createdTimeStr = [dfm stringFromDate:createdTime];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:createdTime];
    NSTimeInterval second = time;       // 时间单位换算成 秒
    NSTimeInterval minute = time / 60;  // 时间单位换算成 分
    NSTimeInterval hour = minute / 60;  // 时间单位换算成 时
    NSTimeInterval day = hour / 24;     // 时间单位换算成 天
    NSTimeInterval year = day / 365;    // 时间单位换算成 年
    
    if (second < 60) {                  // 1分钟之内显示 "刚刚"
        return @"刚刚";
    } else if (minute < 60) {           // 1小时之内显示 "x分钟前"
        return [NSString stringWithFormat:@"%.f分钟前", minute];
    } else if (hour < 24) {             // 1天之内显示 "x小时前"
        return [NSString stringWithFormat:@"%.f小时前", hour];
    } else if (day < 7) {               // 1周之内显示 "x天前"
        return [NSString stringWithFormat:@"%.f天前", day];
    } else if (year >= 1) {             // 1年以前显示 "xxxx年x月x日"
        dfm.dateFormat = @"yyyy年M月d日";
        return [dfm stringFromDate:createdTime];
    } else {                            // 1年以内显示 "x月x日 x点x分"
        return createdTimeStr;
    }
}

#pragma mark 2.2、重写来源set方法格式化存储
-(void)setSource:(NSString *)source
{
    // 源source结构为: <a href="http://app.weibo.com/t/feed/4ACxed" rel="nofollow">iPad客户端</a>
    NSInteger begin = [source rangeOfString:@">"].location + 1;
    NSInteger end = [source rangeOfString:@"</a>"].location;
    NSString *tempStr = [source substringWithRange:NSMakeRange(begin, end - begin)];
    
    // 从字符串取出"iPad客户端"再在前面拼接"来自"
    _source = [NSString stringWithFormat:@"来自%@", tempStr];
}
@end
