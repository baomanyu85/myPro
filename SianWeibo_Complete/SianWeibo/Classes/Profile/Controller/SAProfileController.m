//
//  SAProfileController.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAProfileController.h"
#import "SAHomeStatusCell.h"
#import "SAHomeStatusCellFrame.h"
#import "SAStatusTool.h"
#import "SAStatusDetailController.h"
#import "MJRefresh.h"

@interface SAProfileController () <MJRefreshBaseViewDelegate>
{
    NSMutableArray      *_myStatusFrame;
    MJRefreshHeaderView *_head;
}
@end

@implementation SAProfileController

#pragma mark - 1、初始化
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        _myStatusFrame = [NSMutableArray array];
        
        self.view.backgroundColor = kBGColor;
        
        self.title = @"我的微博";
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 加载数据
        [self loadProfileData];
        
        [self loadRefreshView];
    }
    
    return self;
}

#pragma mark 1.1、加载数据
- (void)loadProfileData
{
    [SAStatusTool statusToolGetMyStatusWithSinceID:0 maxID:0 Success:^(NSArray *array) {
        
        for (SAStatus *status in array) {
            
            SAHomeStatusCellFrame *statusFrame = [[SAHomeStatusCellFrame alloc] init];
            statusFrame.dataModel = status;
            [_myStatusFrame addObject:statusFrame];
            
        }
        
    } failurs:^(NSError *error) {
        
        MyLog(@"获取我的微博详情失败！");
        
    }];
}
#pragma mark 1.2、添加下拉上拉控件
- (void)loadRefreshView
{
    // 1、下拉刷新控件
    MJRefreshHeaderView *head = [MJRefreshHeaderView header];
    head.scrollView = self.tableView;
    head.delegate = self;
    _head = head;
    
    // 2、上拉加载更多控件
    MJRefreshFooterView *foot = [MJRefreshFooterView footer];
    foot.scrollView = self.tableView;
    foot.delegate = self;
}

#pragma mark - 2、Table view data source
#pragma mark 2.1、表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myStatusFrame.count;
}

#pragma mark 2.2、表格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_myStatusFrame[indexPath.row] cellHeight];
}

#pragma mark 2.3、表格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"myStatusCell";
    SAHomeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SAHomeStatusCell alloc] init];
    }
    cell.cellFrame = _myStatusFrame[indexPath.row];
    return cell;
}

#pragma mark - 3、代理方法
#pragma mark 3.1、表格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAStatusDetailController *detail = [[SAStatusDetailController alloc] initWithStyle:UITableViewStylePlain];
    
    detail.status = (SAStatus *)[_myStatusFrame[indexPath.row] dataModel];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark 3.2、刷新数据事件处理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        
        // 下拉操作加载最新数据
        [self loadNewStatus:refreshView];
        
    } else {
        
        // 上拉操作加载更多数据
        [self loadMoreStatus:refreshView];
    }
}

#pragma mark 3.2.1、下拉加载最新
- (void)loadNewStatus:(MJRefreshBaseView *)refreshView
{
    // 1、取出首个模型数据
    SAHomeStatusCellFrame *tempStatus = [_myStatusFrame firstObject];
    long long firstStatusID = tempStatus.dataModel.ID;
    
    // 2、发送请求，请求比首个模型数据更新的数据内容
    [SAStatusTool statusToolGetMyStatusWithSinceID:firstStatusID maxID:0 Success:^(NSArray *array) {
        
        // 3、将新请求到的数据转为数据框架模型并添加到框架模型数组前端
        NSArray *newFrame = [self statusFrameTranslateFromStatusArray:array];
        [_myStatusFrame insertObjects:newFrame atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrame.count)]];
        
        // 4、刷新数据，停止刷新
        [self.tableView reloadData];
        [refreshView endRefreshing];
        
    } failurs:^(NSError *error) {
        
        [refreshView endRefreshing];    // 停止刷新
        
        MyLog(@"首页数据加载失败-%@", [error localizedDescription]);
        
    }];
}

#pragma mark 3.2.2、上拉加载更多
- (void)loadMoreStatus:(MJRefreshBaseView *)refreshView
{
    SAHomeStatusCellFrame *tempStatus = [_myStatusFrame lastObject];
    long long lastStatusID = tempStatus.dataModel.ID;
    
    // 调用SAStatusTool方法直接加载数据到模型数组
    [SAStatusTool statusToolGetStatusWithSinceID:0 maxID:lastStatusID - 1 Success:^(NSArray *array) {
        
        NSArray *newFrame = [self statusFrameTranslateFromStatusArray:array];
        
        [_myStatusFrame addObjectsFromArray:newFrame];
        
        [self.tableView reloadData];    // 加载数据后刷新表格
        
        [refreshView endRefreshing];    // 停止刷新
        
    } failurs:^(NSError *error) {
        
        [refreshView endRefreshing];    // 停止刷新
        
        MyLog(@"%@", [error localizedDescription]);
        
    }];
}

#pragma mark 3.2.3、模型转换工具
// 将请求到的微博数据模型转成微博框架模型
- (NSArray *)statusFrameTranslateFromStatusArray:(NSArray *)statusArray
{
    NSMutableArray *statusFrameArray = [NSMutableArray array];
    for (SAStatus *status in statusArray) {
        SAHomeStatusCellFrame *statusCellFrame = [[SAHomeStatusCellFrame alloc] init];
        statusCellFrame.dataModel = status;
        [statusFrameArray addObject:statusCellFrame];
    }
    return statusFrameArray;
}
@end
