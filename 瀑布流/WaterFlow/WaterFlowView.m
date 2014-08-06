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
@property (assign, nonatomic) NSInteger columnNumbers;

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
    
    if (count == 0) {
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
    NSInteger dataCount = [self rowsCount];
    
    if (self.indexPaths == nil) {
        self.indexPaths = [NSMutableArray arrayWithCapacity:dataCount];
    } else {
        [self.indexPaths removeAllObjects];
    }
    for (NSInteger i = 0; i < dataCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        [self.indexPaths addObject:indexPath];
    }
    
    // 2. 布局界面
    // 1) 计算每列宽度
    CGFloat colW = self.bounds.size.width / self.columnNumbers;
    
    // 2) 使用一个数组，记录每列的当前Y值
    CGFloat currentY[_columnNumbers];
    for (NSInteger i = 0; i < _columnNumbers; i ++) {
        currentY[i] = 0.0;
    }
    
    for (NSIndexPath *indexPath in self.indexPaths) {
        
        // 从MainViewController的数据源方法，获取单元格
        WaterFlowCellView *cell = [self.dataSource waterFlowView:self cellForRowAtIndexPath:indexPath];
        
        // 获取单元格的高度
        CGFloat h = [self.delegate waterFlowView:self heightForRowAtIndexPath:indexPath];
        
        // 列数
        NSInteger col = indexPath.row % _columnNumbers;
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
    for (NSInteger i = 0; i < _columnNumbers; i++) {
        if (currentY[i] > maxH) {
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
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterFlowView:)]) {
        number = [self.dataSource numberOfColumnsInWaterFlowView:self];
    }
    
    _columnNumbers = number;
    
    return _columnNumbers;
}

#pragma mark 获取数据行数
- (NSInteger)rowsCount
{
    return [self.dataSource waterFlowView:self numberOfRowsInColumns:0];
}


@end
