//
//  WaterFlowView.h
//  瀑布流
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
//  目的：模仿UITableView的实现
//

/*
 在对象之间的通讯，目前接触了两种方式：
 
 1. 代理协议
    1> 必须针对每一个方法，去编写具体的实现，在开发时会上下切换代码
    2> 对于复杂对象的开发，使用代理协议，通常便于调试和扩展
    3> 使用@optional描述符，可以指定方法不一定被实现
 
 2. 块代码
    1> 所有代码集成在一起，便于维护，便于书写
    2> 适合于少量的协议方法，如果方法过多，开发难度会直线上升
    3> 没有@optional描述符
 
 如何选择代理方法的可选和必选！
 
 如果方法不实现，会影响整体运行，此类方法必须要实现！
 
 一. 新的问题
 
 代理方法的调用：
    由WaterFlowView通知其代理执行相应的协议方法
 */

#import <UIKit/UIKit.h>

@class WaterFlowView;
@class WaterFlowCellView;

#pragma mark - 数据源协议方法
@protocol WaterFlowViewDataSource <NSObject>

// 在每一列中的数据行数
- (NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns;

// 指定indexPath位置的单元格视图
- (WaterFlowCellView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// 使用@optional描述符，可以指定方法不一定被实现
@optional
// 指定列数
- (NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView;

@end

#pragma mark - 代理协议方法

/*
 1. <NSObject>表示继承自NSObject对象都可以遵守代理协议
 2. 如果当前对象的父类有delegate属性，会自动合并
 */
@protocol WaterFlowViewDelegate <NSObject, UIScrollViewDelegate>

@optional
// 1. 选中单元格
- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

// 2. 指定indexPath单元格的行高
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterFlowView : UIScrollView

@property (weak, nonatomic) id<WaterFlowViewDataSource>dataSource;
@property (weak, nonatomic) id<WaterFlowViewDelegate>delegate;

#pragma mark 刷新数据
- (void)reloadData;

@end
