//
//  UIImage+SA.m
//  SianWeibo
//
//  Created by yusian on 14-4-11.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  

#import "UIImage+SA.h"
#import "NSString+SA.h"

@implementation UIImage (SA)

+ (UIImage *)fullScreenImage:(NSString *)string
{
    // 根据屏幕高度判断iphone5
    if (isIPhone5) {
        
        string = [string fileAppend:@"-568h@2x"];
    
    }
    return [self imageNamed:string];
}

// 自动拉伸图片
+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
}

@end
