//
//  SAStatusDetailCell.m
//  SianWeibo
//
//  Created by yusian on 14-4-23.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAStatusDetailCell.h"
#import "SADetailRetweetDock.h"
#import "SAStatusDetailCellFrame.h"
#import "SAStatusDetailController.h"
#import "SAMainController.h"

@interface SAStatusDetailCell ()
{
    SADetailRetweetDock *_retweetDock;
}
@end

@implementation SAStatusDetailCell

#pragma mark - 1、初始化
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 在父类的基础上增加一个转发体Dock工具栏
        _retweetDock = [[SADetailRetweetDock alloc] init];
        [self.retweet addSubview:_retweetDock];
        [self.retweet addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retweetClick)]];
    }
    return self;
}

#pragma mark - 2、内容赋值
-(void)setCellFrame:(SAStatusDetailCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    // 调用父类的方法将共有的控件赋值，再将特有的控件赋值
    _retweetDock.status = cellFrame.dataModel.retweetedStatus;
}

#pragma mark - 3、点击事件监听
// 点击某Cell转发体区域进入该转发微博的详情页面
- (void)retweetClick
{
    SAStatusDetailController *detailControl = [[SAStatusDetailController alloc] init];
    detailControl.title = @"转发微博详情";
    detailControl.status = self.cellFrame.dataModel.retweetedStatus;
    SAMainController *mainControl = (SAMainController *)self.window.rootViewController;
    UINavigationController *currentControl = (UINavigationController *)mainControl.controller;
    [currentControl pushViewController:detailControl animated:YES];
}

#pragma mark - 4、Cell标记写成类方法
+(NSString *)ID
{
    return @"StatusDetailCell";
}
@end
