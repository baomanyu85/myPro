//
//  UIBarButtonItem+SA.h
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  自定义导航条按钮样式

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SA)

- (id)initWithImageName:(NSString *)imageName highLightedImageName:(NSString *)highLight addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (id)barButtonItemWithImageName:(NSString *)imageName highLightedImageName:(NSString *)highLight addTarget:(id)target action:(SEL)action;

@end
