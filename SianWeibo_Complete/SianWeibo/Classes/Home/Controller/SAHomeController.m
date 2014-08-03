//
//  SAHomeController.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  首页控制器

#import "SAHomeController.h"
#import "NSString+SA.h"
#import "UIBarButtonItem+SA.h"
#import "SAStatusTool.h"
#import "SAHomeStatusCell.h"
#import "MJRefresh.h"
#import "UIImage+SA.h"
#import "SAStatusDetailController.h"
#import "SAReservedController.h"
#import "SASendController.h"


@interface SAHomeController () <MJRefreshBaseViewDelegate>
{
    MJRefreshBaseView       *_head;
    NSMutableArray          *_statusFrameArray;  // 数据框架模型数组
}

@end

@implementation SAHomeController

#pragma mark - 1、初始化
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.view.backgroundColor = kBGColor;
        
    }
    return self;
}

#pragma mark - 2、添加子控件
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _statusFrameArray = [NSMutableArray array];
    
    // 1、设置基本界面
    [self loadBasicUI];
    
    // 2、添加上拉下拉刷新控件
    [self loadRefreshView];
    
}

#pragma mark 2.1、添加基本界面
- (void)loadBasicUI
{
    
    self.title = @"首页";
    
    // 用自定的分类方法给导航条添加左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_compose.png" highLightedImageName:@"navigationbar_compose_highlighted.png" addTarget:self action:@selector(leftButtonClick)];
    
    // 用自定的分类方法给导航条添加右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_pop.png" highLightedImageName:@"navigationbar_pop_highlighted.png" addTarget:self action:@selector(rightButtonClick)];
    
}

#pragma mark 2.2、添加下拉上拉控件
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

#pragma mark - 3、设置Cell
#pragma mark - 3.1、设置Cell总行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 框架模型个数即为单元格数
    return _statusFrameArray.count;
}

#pragma mark 3.2、设置各Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取对应数据模型数组中的对应数据模型的值
    return [_statusFrameArray[indexPath.row] cellHeight];
}

#pragma mark 3.3、设置各Cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAHomeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:[SAHomeStatusCell ID]];
    
    if (cell == nil){
        cell = [[SAHomeStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SAHomeStatusCell ID]];
    }
    
    // 单元格内容由框架模型提供
    cell.cellFrame = _statusFrameArray[indexPath.row];
    
    return cell;
}

#pragma mark - 4、事件处理
#pragma mark - 4.1、Cell点击事件处理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SAStatusDetailController *detail = [[SAStatusDetailController alloc] initWithStyle:UITableViewStylePlain];
    
    detail.status = (SAStatus *)[_statusFrameArray[indexPath.row] dataModel];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - 4.2、刷新数据事件处理
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

#pragma mark 4.2.1、下拉刷新数据事件处理
- (void) loadNewStatus:(MJRefreshBaseView *)refreshView
{
    // 1、取出首个模型数据
    SAHomeStatusCellFrame *tempStatus = [_statusFrameArray firstObject];
    long long firstStatusID = tempStatus.dataModel.ID;
    
    // 2、发送请求，请求比首个模型数据更新的数据内容
    [SAStatusTool statusToolGetStatusWithSinceID:firstStatusID maxID:0 Success:^(NSArray *array) {
        
        // 3、将新请求到的数据转为数据框架模型并添加到框架模型数组前端
        NSArray *newFrame = [self statusFrameTranslateFromStatusArray:array];
        [_statusFrameArray insertObjects:newFrame atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrame.count)]];
        
        // 4、刷新数据，停止刷新
        [self.tableView reloadData];
        [refreshView endRefreshing];
        
        // 5、显示提示
        [self showNewStatusMessage:newFrame.count];
        
    } failurs:^(NSError *error) {
        
        [refreshView endRefreshing];    // 停止刷新
        
        MyLog(@"首页数据加载失败-%@", [error localizedDescription]);
        
    }];
    
}

#pragma mark 4.2.2、上拉刷新数据事件处理
- (void)loadMoreStatus:(MJRefreshBaseView *)refreshView
{
    
    SAHomeStatusCellFrame *tempStatus = [_statusFrameArray lastObject];
    long long lastStatusID = tempStatus.dataModel.ID;
    
    // 调用SAStatusTool方法直接加载数据到模型数组
    [SAStatusTool statusToolGetStatusWithSinceID:0 maxID:lastStatusID - 1 Success:^(NSArray *array) {
        
        NSArray *newFrame = [self statusFrameTranslateFromStatusArray:array];
        
        [_statusFrameArray addObjectsFromArray:newFrame];
        
        [self.tableView reloadData];    // 加载数据后刷新表格
        
        [refreshView endRefreshing];    // 停止刷新
        
    } failurs:^(NSError *error) {
        
        [refreshView endRefreshing];    // 停止刷新
        
        MyLog(@"%@", [error localizedDescription]);
        
    }];
    
}

#pragma mark - 4.3 其他按钮事件
#pragma mark - 4.3.1、首页导航左按钮事件
- (void)leftButtonClick
{
    
    SASendController *send = [[SASendController alloc] init];
    
    [self.navigationController pushViewController:send animated:YES];
}

#pragma mark 4.3.2、首页导航右按钮事件
- (void)rightButtonClick
{
    MyLog(@"首页右按钮");
    
    SAReservedController *reserved = [[SAReservedController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:reserved animated:YES];
}

#pragma mark - 5、其他方法
#pragma mark - 5.1、刷新最新微博数据
- (void)refresh
{
    [_head beginRefreshing];
}

#pragma mark 5.2、显示下拉刷新结果
- (void)showNewStatusMessage:(NSUInteger)count
{
    // 1、创建按钮设置基本属性
    UIButton *msgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    msgButton.enabled = NO;
    msgButton.adjustsImageWhenDisabled = NO;
    NSString *title;
    
    if (count) {    // 如果count不为空则显示"n条新微博"
        title = [NSString stringWithFormat:@"恭喜获得 %d 条小龙虾", (int)count];
    } else {        // 如果count值为0则显示"无最新微博"
        title = @"很遗憾 一无所获";
    }
    
    msgButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [msgButton setTitle:title forState:UIControlStateNormal];
    [msgButton setBackgroundImage:[UIImage resizeImage:@"timeline_new_status_background.png"] forState:UIControlStateNormal];
    [self.navigationController.view insertSubview:msgButton belowSubview:self.navigationController.navigationBar];
    
    // 2、设置显示动画
    CGFloat height = 44;
    // 自适应ios7与ios6导航条控件原点
    CGFloat y = self.navigationController.navigationBar.frame.origin.y;
    msgButton.frame = CGRectMake(0, y, self.tableView.frame.size.width, height);
    msgButton.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{   // 半秒时间淡出效果
        
        msgButton.alpha = 0.9;
        msgButton.transform = CGAffineTransformTranslate(msgButton.transform, 0, height);
        
    } completion:^(BOOL finished) {                 // 停留1.5秒后弹回
        [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            msgButton.transform = CGAffineTransformTranslate(msgButton.transform, 0, -height);
            msgButton.alpha = 0;
            
        } completion:^(BOOL finished) {             // 动画结束移除控件
            [msgButton removeFromSuperview];
        }];
    }];
    
    
}

#pragma mark 5.3、模型转换工具
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
