//
//  NSString+SA.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  自定义字符串拼接方法

#import "NSString+SA.h"

@implementation NSString (SA)

- (NSString *)fileAppend:(NSString *)string
{
    // 1、获取文件扩展名
    NSString *ext = [self pathExtension];
    
    // 2、去掉文件扩展名
    NSString *str = [self stringByDeletingPathExtension];
    
    // 3、拼接新加字符串
    str = [str stringByAppendingString:string];
    
    // 4、拼接扩展名
    str = [str stringByAppendingPathExtension:ext];
    
    return str;

}

@end
