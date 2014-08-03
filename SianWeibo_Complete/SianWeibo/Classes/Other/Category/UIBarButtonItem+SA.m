//
//  UIBarButtonItem+SA.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  自定义导航条按钮样式

#import "UIBarButtonItem+SA.h"

@implementation UIBarButtonItem (SA)

#pragma mark 按钮样式设计及事件处理
- (id)initWithImageName:(NSString *)imageName highLightedImageName:(NSString *)highLight addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    // 创建一个普通按钮并设置按钮样式
    UIButton *button = [[UIButton alloc] init];
    UIImage *image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highLight] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:controlEvents];
    CGSize buttonSize = image.size;
    button.frame = (CGRect){CGPointZero, buttonSize};
    
    // 设置按钮事件处理
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    // 将item初始化为上述按钮样式
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

#pragma mark 按钮样式设计及事件处理类方法
+ (id)barButtonItemWithImageName:(NSString *)imageName highLightedImageName:(NSString *)highLight addTarget:(id)target action:(SEL)action
{
    return [[self alloc] initWithImageName:imageName highLightedImageName:highLight addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
