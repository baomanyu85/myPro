//
//  SAStatusDetailController.m
//  SianWeibo
//
//  Created by yusian on 14-4-22.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAStatusDetailController.h"
#import "SAStatusDetailCell.h"
#import "SAStatusDetailCellFrame.h"
#import "SAStatusDetailDock.h"
#import "SAStatusTool.h"
#import "SACommentCell.h"
#import "SACommentCellFrame.h"
#import "SAReportCell.h"
#import "SAReportCellFrame.h"
#import "MJRefresh.h"

@interface SAStatusDetailController () <SAStatusDetailDockDelegate, MJRefreshBaseViewDelegate>
{
    SAStatusDetailDock          *_detailDock;
    NSMutableArray              *_commentFrames;
    NSMutableArray              *_reportFrames;
    SAStatusDetailCellFrame     *_detailFrame;
    StatusDetailDockButtonType  _buttonType;
    MJRefreshFooterView         *_footer;
    MJRefreshHeaderView         *_header;
    BOOL                        _isHiddenFooter;
    
}
@end

@implementation SAStatusDetailController

#pragma mark - 1、初始化
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.view.backgroundColor = kBGColor;
        self.title = @"微博正文详情";
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kCellMargins, 0);
        
        _commentFrames = [NSMutableArray array];
        _reportFrames = [NSMutableArray array];
        
        SAStatusDetailDock *detailDock = [[SAStatusDetailDock alloc] init];
        detailDock.delegate = self;
        _detailDock = detailDock;
        

    }
    return self;
}

#pragma mark 1.1、页面加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _footer = [MJRefreshFooterView footer];
    _footer.hidden = YES;
    _footer.scrollView = self.tableView;
    _footer.delegate = self;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.tableView;
    _header.delegate = self;
    
}

#pragma mark 1.2、微博内容赋值
-(void)setStatus:(SAStatus *)status
{
    // 通过外界传进来的模型数据，调用自己的框架模型计算出各子视图的数据尺寸位置
    _status = status;
    _detailFrame = [[SAStatusDetailCellFrame alloc] init];
    _detailFrame.dataModel = status;
    [self statusDetailDock:_detailDock clickButton:kStatusDetailDockButtonTypeComments];
}

#pragma mark - 2、Cell设置
#pragma mark - 2.1、表格组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark 2.2、每组头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    return kDetailDockH;
}

#pragma mark 2.3、每组表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _footer.hidden = _isHiddenFooter;
    
    if (section == 0) {
        return 1;
    } else {
        return [[self ArrayByButtonType] count];
    }
}

#pragma mark 2.4、每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    } else {
        return [[self ArrayByButtonType][indexPath.row] cellHeight];
    }
}

#pragma mark 2.5、每行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        SAStatusDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:[SAStatusDetailCell ID]];
        
        if (detailCell == nil) {
            detailCell = [[SAStatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SAStatusDetailCell ID]];
        }
        
        detailCell.cellFrame = _detailFrame;
        return detailCell;
        
    } else if (_buttonType == kStatusDetailDockButtonTypeComments) {
    
        SACommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:[SACommentCell ID]];
        
        if (commentCell == nil) {
            commentCell = [[SACommentCell alloc] init];
        }
        
        commentCell.cellFrame = _commentFrames[indexPath.row];
        [commentCell setGroupCellStyleWithTableView:tableView cellForRowAtIndexPath:indexPath];
        return commentCell;
        
    } else {// if (_buttonType == kStatusDetailDockButtonTypeResports) {
    
        SAReportCell *reportCell = [tableView  dequeueReusableCellWithIdentifier:[SAReportCell ID]];
        
        if (reportCell == nil) {
            reportCell = [[SAReportCell alloc] init];
        }
    
        reportCell.cellFrame = _reportFrames[indexPath.row];
        [reportCell setGroupCellStyleWithTableView:tableView cellForRowAtIndexPath:indexPath];
        return reportCell;
    }
}

#pragma mark 2.6、每组头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _detailDock.status = _status;
    return _detailDock;
}

#pragma mark 2.7、高亮属性设置
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果是第0组，则单元络点击时，不显示高度
    if (indexPath.section) return YES;
    return NO;
}

#pragma mark - 3、事件处理
#pragma mark - 3.1、Cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark 3.2、Dock条按钮点击事件
- (void)statusDetailDock:(SAStatusDetailDock *)statusDetailDock clickButton:(StatusDetailDockButtonType)buttonType
{
    _buttonType = buttonType;
    
    // 先刷新加载现有数据，再向服务器请求最新数据
    [self.tableView reloadData];
    
    if (buttonType == kStatusDetailDockButtonTypeComments) {            // 评论按钮
        
        // 加载新的评论数据
        [self loadNewComments];
        
    } else if (buttonType == kStatusDetailDockButtonTypeResports) {     // 转发按钮
        
        // 加载新的转发数据
        [self loadNewReports];
        
    } else if (buttonType == kStatusDetailDockButtonTypeAttitudes) {    // 点赞按钮
        
        
    }
}

#pragma mark 3.2.1、加载更多评论
- (void)loadNewComments
{
    long long firstId = [[[_commentFrames firstObject] dataModel] ID];
    
    [SAStatusTool statusToolGetCommentsWithStatusID:_status.ID sinceID:firstId maxID:0 Success:^(NSArray *commentsArray, NSUInteger totalNumber, long long nextCursor) {
        
        NSUInteger commentTotal = totalNumber;
        
        if (commentTotal) _status.commentsCount = commentTotal;
        
        NSArray *tempArray = [self arrayBaseArray:commentsArray Class:[SACommentCellFrame class]];
        
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, tempArray.count)];
        
        [_commentFrames insertObjects:tempArray atIndexes:indexSet];
        
        _isHiddenFooter = !nextCursor;
        
        [self.tableView reloadData];
        
    } failurs:^(NSError *error) {
        
        MyLog(@"评论数据请求失败-%@", [error localizedDescription]);
        
    }];
}

#pragma mark 3.2.2、加载更多转发
- (void)loadNewReports
{
    long long firstId = [[[_reportFrames firstObject] dataModel] ID];
    
    [SAStatusTool statusToolGetReportsWithStatusID:_status.ID sinceID:firstId maxID:0 Success:^(NSArray *reportsArray, NSUInteger totalNumber, long long nextCursor) {
        
        NSUInteger reportTotal = totalNumber;
        
        if (reportTotal) _status.repostsCount = reportTotal;
        
        NSArray *tempArray = [self arrayBaseArray:reportsArray Class:[SAReportCellFrame class]];
        
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, tempArray.count)];
        
        [_reportFrames insertObjects:tempArray atIndexes:indexSet];
        
        _isHiddenFooter = !nextCursor;
        
        [self.tableView reloadData];
        
    } failurs:^(NSError *error) {
        
        MyLog(@"转发数据请求失败-%@", [error localizedDescription]);
        
    }];
}

#pragma mark 3.4 上拉加载更多
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        
        
        if (_buttonType == kStatusDetailDockButtonTypeComments) {   // 评论按钮下拉加载更多
            
            [self loadMoreComments:refreshView];
            
        } else {                                                    // 转发Cell下拉加载更多
            
            [self loadMoreReports:refreshView];
        }
    } else if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
    
        [self loadStatusDetail:refreshView];
    
    }
}

#pragma mark 3.4.1、上拉加载更多评论
- (void)loadMoreComments:(MJRefreshBaseView *)refreshView
{
    long long commentLastId = [[[_commentFrames lastObject] dataModel] ID];
    
    [SAStatusTool statusToolGetCommentsWithStatusID:_status.ID sinceID:0 maxID:commentLastId - 1 Success:^(NSArray *commentsArray, NSUInteger totalNumber, long long nextCursor) {
        
        NSArray *tempArray = [self arrayBaseArray:commentsArray Class:[SACommentCellFrame class]];
        
        [_commentFrames addObjectsFromArray:tempArray];
        
        _isHiddenFooter = !nextCursor;          // nextCursor为0则隐藏
        
        [self.tableView reloadData];
        
        [refreshView endRefreshing];
        
    } failurs:^(NSError *error) {
        
        MyLog(@"评论上拉加载更多失败");
        
        [refreshView endRefreshing];
        
    }];
}

#pragma mark 3.4.2、上拉加载更多转发
- (void)loadMoreReports:(MJRefreshBaseView *)refreshView
{
    long long reportLastId = [[[_reportFrames lastObject] dataModel] ID];
    
    [SAStatusTool statusToolGetReportsWithStatusID:_status.ID sinceID:0 maxID:reportLastId - 1 Success:^(NSArray *reportsArray, NSUInteger totalNumber, long long nextCursor) {
        
        NSArray *tempArray = [self arrayBaseArray:reportsArray Class:[SAReportCellFrame class]];
    
        [_reportFrames addObjectsFromArray:tempArray];
        
        _isHiddenFooter = !nextCursor;      // nextCursor为0则隐藏
        
        [self.tableView reloadData];
        
        [refreshView endRefreshing];
        
    } failurs:^(NSError *error) {
        
        MyLog(@"转发上拉加载更多失败");
        
        [refreshView endRefreshing];
        
    }];

}

#pragma mark 3.4.3、下拉刷新微博详情
- (void)loadStatusDetail:(MJRefreshBaseView *)refreshView
{
    [SAStatusTool statusTOolGetSingleStatusWithStatusID:_status.ID Success:^(SAStatus *status) {
        
        _status = status;
        
        [self.tableView reloadData];
        
        [refreshView endRefreshing];
        
    } failurs:^(NSError *error) {
        
        MyLog(@"请求单条微博详情失败");
        
    }];
}

#pragma mark - 4、代码重构方法
#pragma mark 4.1、按钮对应模型
- (NSMutableArray *)ArrayByButtonType
{
    if (_buttonType == kStatusDetailDockButtonTypeComments) {
        
        return _commentFrames;
        
    } else if (_buttonType == kStatusDetailDockButtonTypeResports) {
        
        return _reportFrames;
        
    } else {
        
        return nil;
    }
}

- (NSArray *)arrayBaseArray:(NSArray *)array Class:(Class)class
{
    NSMutableArray *frameArray = [NSMutableArray array];
    
    for (SABaseText *dataModel in array) {
        
        SABaseTextCellFrame *frame = [[class alloc] init];
        
        [frame setDataModel:dataModel withAvataType:kAvataTypeDefault];
        
        [frameArray addObject:frame];
    }
    return frameArray;
}

- (void)dealloc
{
    [_header free];
    [_footer free];
}

@end
