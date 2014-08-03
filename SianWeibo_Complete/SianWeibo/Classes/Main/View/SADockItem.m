//
//  SADockItem.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Dock按钮样式设置

#import "SADockItem.h"
#define kPercentage 0.6
#define kBgImageName @"tabbar_slider.png"

@implementation SADockItem

#pragma mark - 1、初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1、图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 2、文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 3、文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        // 4、设置selected状态背景
        [self setBackgroundImage:[UIImage imageNamed:kBgImageName] forState:UIControlStateSelected];
        
    }
    return self;
}

#pragma mark - 2、设置Frame

#pragma mark - 2.1、图片尺寸位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect               // 按钮中图片占比上方60%，位置居中
{
    CGFloat imageWith = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * kPercentage;
    return CGRectMake(0, 0, imageWith, imageHeight);
}

#pragma mark 2.2、文字尺寸位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect               // 按钮文字占比下方40%，位置居中上移2个像素
{
    CGFloat titleY = contentRect.size.height * kPercentage - 2;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - kPercentage);
    return CGRectMake(0, titleY, width, height);
}

#pragma mark - 附、按钮高亮事件
- (void)setHighlighted:(BOOL)highlighted {}                         // 重写高亮事件为空，即跳过高亮事件过程，即点击按钮不会有高亮效果


@end
