//
//  MainViewController.m
//  瀑布流
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MainViewController.h"
#import "WaterFlowCellView.h"
#import "MGJData.h"
#import "UIImageView+WebCache.h"

#define kColNumber 4

@interface MainViewController ()

// 数据列表
@property (strong, nonatomic) NSArray *dataList;

@end

@implementation MainViewController

#pragma mark - 私有方法
#pragma mark 加载蘑菇街数据
- (void)loadMGJData
{
    // 1. 从沙盒中取出plist
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"123" withExtension:@"plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:url];
    NSArray *array = dict[@"result"][@"list"];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        NSDictionary *showDict = dict[@"show"];
        
        MGJData *data = [[MGJData alloc]init];
        [data setValuesForKeysWithDictionary:showDict];
        
        [arrayM addObject:data];
    }
    
    self.dataList = arrayM;
    
    // 2. 强烈提醒，需要测试
  //  NSLog(@"%@", self.dataList);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadMGJData];
}

#pragma mark - 数据源方法
#pragma mark - 列数
- (NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView
{
    return kColNumber;
}

#pragma mark - 行数
- (NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumns:(NSInteger)columns
{
  //  NSLog(@"----%ld",self.dataList.count);
    return self.dataList.count;
}

- (WaterFlowCellView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MyCell";
//    WaterFlowCellView *cell = waterFlowView.deq
    WaterFlowCellView *cell = [[WaterFlowCellView alloc]initWithResueIdentifier:ID];
    
    // 设置cell
    MGJData *data = self.dataList[indexPath.row];
    
    [cell.textLabel setText:data.price];
    
    // 异步加载图像
    /*
     提示，使用SDWebImage可以指定缓存策略，包括内存缓存 并 磁盘缓存
     */
    [cell.imageView setImageWithURL:data.img];
    
    return cell;
}

#pragma mark - 每个单元格的高度
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGJData *data = self.dataList[indexPath.row];
    
    // 计算图像的高度
    // 例如：h = 275 w = 200 目前的宽度是 320 / 3 = 106.667
    CGFloat colWidth = self.view.bounds.size.width / kColNumber;
    
    return colWidth / data.w * data.h;
}

@end
