//
//  SAMessageController.m
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAMessageController.h"
#import "UIBarButtonItem+SA.h"
#import "SATableViewCell.h"
#import "SAReservedController.h"

@interface SAMessageController ()

@end

@implementation SAMessageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"消息";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发私信" style:UIBarButtonItemStyleBordered target:self action:@selector(enterReservedView)];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (void)enterReservedView
{
    SAReservedController *reserved = [[SAReservedController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:reserved animated:YES];
}

@end
