//
//  SAStatusDetailController.h
//  SianWeibo
//
//  Created by yusian on 14-4-22.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SAStatus;

@interface SAStatusDetailController : UITableViewController

@property (nonatomic, strong) SAStatus *status;     // 数据模型，接收传进来的模型数据

@end
