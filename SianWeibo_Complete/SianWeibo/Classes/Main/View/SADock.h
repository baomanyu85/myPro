//
//  SADock.h
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Dock基本样式设置

#import <UIKit/UIKit.h>
#import "SADockItem.h"
@class SADock;

#pragma mark - SADock协议
@protocol SADockDelegate <NSObject>

@optional
- (void)dock:(SADock *)dock itemSelectFrom:(NSInteger)sourceIndex to:(NSInteger)toIndex;

@end

#pragma mark - SADock类声明
@interface SADock : UIView 

// Dock中的按钮抽取出来做为成员变量方便事件响应与方法传递
@property (nonatomic, strong)   SADockItem          *item;

// 定义一个代理属性，将Dock中的按钮事件供外界调用
@property (nonatomic, weak)     id<SADockDelegate>  delegate;

// 当前被选择的按钮序号
@property (nonatomic, assign)   NSUInteger          indexSelected;

// Dock上添加按键的一个方法
- (void)addItemWithIcon:(NSString *)iconName selectedIcon:(NSString *)selecteded title:(NSString *)title;

@end
