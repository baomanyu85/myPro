//
//  SADockController.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Dock控制器

#import "SADockController.h"

@interface SADockController () <SADockDelegate>

@end

@implementation SADockController

#pragma  mark - 1、初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addDock];     // 创建一个Dock
}

#pragma mark 1.1、添加子控件
// 将Dock添加到当前控制器的View上面，即调整Dock尺寸位置让其显示到屏幕最底部
- (void)addDock
{
    _dock = [[SADock alloc] init];
    _dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight);
    [self.view addSubview:_dock];
    
    // 设置Dock的代理为当前控制器
    _dock.delegate = self;
}


#pragma mark - 2、事件处理
// Dock的代理方法，当Dock上按钮被点击时，切换相应的View到当前控制器上显示
-(void)dock:(SADock *)dock itemSelectFrom:(NSInteger)sourceIndex to:(NSInteger)toIndex
{
    if (toIndex < 0 || toIndex >= self.childViewControllers.count) return;
    if (sourceIndex == toIndex) [self clickWithDockButtonIndex:toIndex];
    // 1、移除之前的View
    UIViewController *oldViewControl = self.childViewControllers[sourceIndex];
    [oldViewControl.view removeFromSuperview];
    
    // 2、展示当前的View并设置尺寸位置
    UIViewController *newViewControl = self.childViewControllers[toIndex];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - dock.frame.size.height;
    newViewControl.view.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:newViewControl.view];
    _controller = newViewControl;
}

#pragma mark 2.1、提供外部响应接口
- (void)clickWithDockButtonIndex:(NSUInteger)index
{
    // 子类实现
}
@end
