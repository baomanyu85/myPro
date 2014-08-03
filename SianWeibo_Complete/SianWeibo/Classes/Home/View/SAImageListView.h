//
//  SAImageListView.h
//  SianWeibo
//
//  Created by yusian on 14-4-19.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  微博配图处理类

#import <UIKit/UIKit.h>

@interface SAImageListView : UIView

@property (nonatomic, strong) NSArray *imageList;

+ (CGSize) sizeOfViewWithImageCount:(NSInteger)count;

@end
