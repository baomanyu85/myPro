//
//  SAMoreController.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAMoreController.h"
#import "UIImage+SA.h"
#import "SATableData.h"
#import "SATableViewCell.h"
#import "UIBarButtonItem+SA.h"
#import "SAReservedController.h"
#import "SAAccountTool.h"
#import "SAOAuthController.h"

@interface SAMoreController ()
{
    NSMutableArray *_dataSource;
}

@end

@implementation SAMoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置控制器标题
    self.title = @"更多";
    
    // 添加导航右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(enterReservedView)];
    
    // 加载数据模型
    [self loadData];
    
    // 创建表格样式
    [self buildTable];

}

#pragma mark - 加载数据模型
- (void)loadData
{
    _dataSource = [NSMutableArray array];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"More" withExtension:@"plist"];
    NSArray *plistData = [NSArray arrayWithContentsOfURL:url];                      // 加载Plist文件到临时数组
    for (int i = 0; i < plistData.count; i++) {                                     // 两个循环嵌套加载数据到模型
        NSMutableArray *array = [NSMutableArray array];                             // --1._dataSource  数组
        [_dataSource addObject:array];                                              // +---2.array      数组(Section)
        for (int j = 0; j < [plistData[i] count]; j ++) {                           // +-----3.data     数据模型(Row)
            SATableData *data = [SATableData tableDateWithDict:plistData[i][j]];    // 将每行数据创建数据模型并以行为单位存储到数组
            [array addObject:data];                                                 // 加载到单位组中
        }
    }
}

#pragma mark - 创建表格
- (void)buildTable
{
    // 清除表格底图，加载表格底色
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kBGColor;
    
    // 设置表格底隔高度，清除表格栅隔线
    self.tableView.sectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - Table view data source
#pragma mark 表格组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return _dataSource.count;
}

#pragma mark 每组表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

#pragma mark 每行表格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sections = [tableView numberOfSections];
    
    // 基本Cell创建
    static NSString *Identifier = @"Cell";
    SATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[SATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    // Cell内容设置
    [cell setGroupCellStyleWithTableView:tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [_dataSource[indexPath.section][indexPath.row] name];
    
    // Cell样式处理
    if (indexPath.section == 2) {                       // 第三组表格右侧需要显示文字
        cell.cellType = kCellTypeLabel;
        cell.accessoryLabel.text = indexPath.row?@"经典模式" : @"有图模式";
    } else if (indexPath.section == sections - 1) {     // 最后一组表格设置成"退出登录"按钮样式
        cell.cellType = kCellRedButton;
    } else {                                            // 其他Cell右侧带小箭头图标
        cell.cellType = kCellTypeArrow;
    }
    
    return cell;
}

#pragma mark - TableView代理方法
// 表格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        
        [[SAAccountTool sharedAccountTool] saveAccount:nil];
        
        [UIView animateWithDuration:1.0 animations:^{
            
            self.view.window.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            exit(0);
            
        }];
        
        
        
    } else {
    
        [self enterReservedView];
    
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)enterReservedView
{
    SAReservedController *reserved = [[SAReservedController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:reserved animated:YES];
}

@end
