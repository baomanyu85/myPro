//
//  WaterFlowView.m
//  瀑布流
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "WaterFlowView.h"
#import "WaterFlowCellView.h"

@interface WaterFlowView()

// indexPath的数组
@property (strong, nonatomic) NSMutableArray *indexPaths;
// 列数
@property (assign, nonatomic) NSInteger numberOfColumns;
// 瀑布流视图单元格的数量
@property (assign, nonatomic) NSInteger numberOfCells;



#pragma mark - 瀑布流视图缓存属性
// 单元格位置数组
@property (strong, nonatomic) NSMutableArray *cellFramesArray;
// 缓冲池集合(可重用单元格集合)
@property (strong, nonatomic) NSMutableSet *reusableCellSet;
// 还需要一个"东西"，记录住当前屏幕上的单元格视图，如果存在，就不再实例化和添加，如此设计可以解决
// 1. 视图不会因为简单的滚动被频繁的增加
// 2. 如果视图移动出屏幕，可以将此视图添加到缓冲池
@property (strong, nonatomic) NSMutableDictionary *screenCellsDict;





@end

@implementation WaterFlowView

#pragma mark - 使用UIView的frame的Setter方法
// 此方法是在重新调整视图大小时调用的，可以利用此方法在横竖屏切换时刷新数据使用
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    NSLog(@"set Frame :%@", NSStringFromCGRect(frame));
    
    [self reloadData];
}

#pragma mark - 加载数据
- (void)reloadData
{
    NSLog(@"加载数据 %d", [self.dataSource waterFlowView:self numberOfRowsInColumns:0]);
    NSInteger count = [self.dataSource waterFlowView:self numberOfRowsInColumns:0];
    
    if (count == 0)
    {
        return;
    }
    
    // 后面再做真正的数据处理
    [self resetView];
}

#pragma mark - 布局视图
// 根据视图属性或数据源方法，生成瀑布流视图界面
- (void)resetView
{
    // 1. 首先初始化根据数据行数indexPaths数组
    NSInteger dataCount = [self numberOfCells];
    
    if (self.indexPaths == nil)
    {
        self.indexPaths = [NSMutableArray arrayWithCapacity:dataCount];
    } else {
        [self.indexPaths removeAllObjects];
    }
    for (NSInteger i = 0; i < dataCount; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        [self.indexPaths addObject:indexPath];
    }
    
    // 2. 布局界面
    // 1) 计算每列宽度
    CGFloat colW = self.bounds.size.width / self.columnNumbers;
    
    // 2) 使用一个数组，记录每列的当前Y值
    CGFloat currentY[_numberOfColumns];
    for (NSInteger i = 0; i < _numberOfColumns; i ++)
    {
        currentY[i] = 0.0;
    }
    
    for (NSIndexPath *indexPath in self.indexPaths)
    {
        
        // 从MainViewController的数据源方法，获取单元格
        WaterFlowCellView *cell = [self.dataSource waterFlowView:self cellForRowAtIndexPath:indexPath];
        
        // 获取单元格的高度
        CGFloat h = [self.delegate waterFlowView:self heightForRowAtIndexPath:indexPath];
        
        // 列数
        NSInteger col = indexPath.row % _numberOfColumns;
        // X
        CGFloat x = col * colW;
        // Y
        CGFloat y = currentY[col];
        
        currentY[col] += h;
        
        [cell setFrame:CGRectMake(x, y, colW, h)];
        
        [self addSubview:cell];
    }
    
    // 要让scrollView滚动，需要设置contentSize
    CGFloat maxH = 0;
    for (NSInteger i = 0; i < _numberOfColumns; i++)
    {
        if (currentY[i] > maxH)
        {
            maxH = currentY[i];
        }
    }
    
    [self setContentSize:CGSizeMake(self.bounds.size.width, maxH)];
}

#pragma mark - 私有方法
#pragma mark 获取列数 getter方法
- (NSInteger)columnNumbers
{
    NSInteger number = 1;
    
    // 对于可选的方法，需要判断数据源是否实现了该方法
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterFlowView:)])
    {
        number = [self.dataSource numberOfColumnsInWaterFlowView:self];
    }
    
    _numberOfColumns = number;
    
    return _numberOfColumns;
}



#pragma mark 获取数据行数
- (NSInteger)numberOfCells
{
    _numberOfCells = [self.dataSource waterFlowView:self numberOfRowsInColumns:0];
    
    return _numberOfCells;
}





#pragma mark - 重新调整视图布局
#pragma mark 判断指定frame是否在屏幕范围之内
- (BOOL)isInScreenWithFrame:(CGRect)frame
{
    return ((frame.origin.y + frame.size.height > self.contentOffset.y) &&
            (frame.origin.y < self.contentOffset.y + self.bounds.size.height));
}

#pragma mark 重新调整视图布局
// layoutSubviews是在视图需要重新布局时被调用的
// ScrollView是靠contentOffset得变化来调整视图的显示的
// 滚动视图时，contentOffset发生变化，意味着视图的内容需要调整
- (void)layoutSubviews
{
    // 根据单元格的数组来放置瀑布流图片
    // 遍历所有的indexPath，放置对应的视图
    NSInteger index = 0;
    for (NSIndexPath *indexPath in self.indexPaths) {
        
        // 检查屏幕视图数组中是否存在该单元格，如果存在，不再实例化
        WaterFlowCellView *cell = self.screenCellsDict[indexPath];
        
        if (cell == nil) {
            // 调用数据源的方法，获取单元格
            // 1. 首先查询可重用单用单元格，如果有，从reusableCellSet返回anyObject
            // 2. 如果没有，实例化
            WaterFlowCellView *cell = [self.dataSource waterFlowView:self cellForRowAtIndexPath:indexPath];
            
            CGRect frame = [self.cellFramesArray[index]CGRectValue];
            
            if ([self isInScreenWithFrame:frame]) {
                [cell setFrame:frame];
                
                [self addSubview:cell];
                
                // 使用indexPath作为key加入屏幕视图字典
                [self.screenCellsDict setObject:cell forKey:indexPath];
            }
        } else {
            // 检查单元格是否移出屏幕，如果是，将其从视图中删除，并且添加到缓冲池
            if (![self isInScreenWithFrame:cell.frame]) {
                // 1) 从屏幕上删除
                [cell removeFromSuperview];
                
                // 2) 加到缓冲池
                [self.reusableCellSet addObject:cell];
                
                // 3) 从屏幕视图字典中删除
                [self.screenCellsDict removeObjectForKey:indexPath];
            }
        }
        
        index++;
    }
    
    // 当self.contentOffset.y > self.contentSize.height开始刷新新的数据
    if (self.contentOffset.y + self.bounds.size.height > self.contentSize.height) {
        // 刷新网络数据，并刷新数据，视图控制器负责刷新数据，
        // 加载数据完成后，通知视图刷新显示
        [self.delegate waterFlowViewRefreshData:self];
    }
    
    NSLog(@"layout subviews %d %f", self.subviews.count, self.contentOffset.y);
}

@end
