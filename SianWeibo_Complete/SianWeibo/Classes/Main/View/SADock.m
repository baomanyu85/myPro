//
//  SADock.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Dock基本样式设置

#import "SADock.h"
#import "SADockItem.h"
#define kBackgroundImageName @"tabbar_background.png"


@implementation SADock

#pragma mark - 1、初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置Dock的背景图片，美化样式
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundImageName]];
    }
    return self;
}

#pragma mark - 2、添加子控件
- (void)addItemWithIcon:(NSString *)iconName selectedIcon:(NSString *)selecteded title:(NSString *)title
{
    SADockItem *item = [[SADockItem alloc] init];
    [self addSubview:item];
    
    [item setTitle:title forState:UIControlStateNormal];                                        // 设置按钮文字
    [item setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];                // 设置按钮不同状态下的图片
    [item setImage:[UIImage imageNamed:selecteded] forState:UIControlStateSelected];
    [item addTarget:self action:@selector(itemEvent:) forControlEvents:UIControlEventTouchDown];// 按钮事件响应
    NSUInteger count = self.subviews.count;
    CGFloat width = self.frame.size.width / count;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < count; i++) {                                                           // 根据按钮个数动态设置按钮尺寸位置
        SADockItem *item = self.subviews[i];
        item.tag = i;
        item.frame = CGRectMake(width * i, 0, width, height);
    }
    
    if (_item == nil) {
        [self itemEvent:self.subviews[0]];                                                      // 默认状态点击第一个按钮
    }
}

#pragma mark - 3、事件响应
// 点击当前按钮，则当前按钮置于被选择状态，其他按钮置于未被选择状态
- (void)itemEvent:(SADockItem *)item
{
    // 0、通知代理
    if ([_delegate respondsToSelector:@selector(dock:itemSelectFrom:to:)]) {
        [_delegate dock:self itemSelectFrom:(NSInteger)_item.tag to:(NSInteger)item.tag];
        _indexSelected = item.tag;
    }
    
    // 1、取消之前按钮的select状态
    _item.selected = NO;
    
    // 2、设置当前按钮select状态
    item.selected = YES;
    
    // 3、重新赋值给成员变量
    _item = item;
}


@end
