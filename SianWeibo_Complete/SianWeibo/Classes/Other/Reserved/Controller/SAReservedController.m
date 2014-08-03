//
//  SAReservedController.m
//  SianWeibo
//
//  Created by yusian on 14-4-23.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  扩展页控制器（临时展示）

#import "SAReservedController.h"

@interface SAReservedController ()

@end

@implementation SAReservedController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"扩展测试页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"temp"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"temp"];
    }
    
    cell.textLabel.text = @"感谢关注，敬请期待...";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

@end
