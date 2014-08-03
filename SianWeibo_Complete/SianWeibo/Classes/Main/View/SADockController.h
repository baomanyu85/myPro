//
//  SADockController.h
//  SianWeibo
//
//  Created by yusian on 14-4-12.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Dock控制器

#import <UIKit/UIKit.h>
#import "SADock.h"

@interface SADockController : UIViewController

@property (nonatomic, strong) SADock *dock;

@property (nonatomic, strong) UIViewController  *controller;

- (void)clickWithDockButtonIndex:(NSUInteger)index;

@end
