//
//  SABaseTextCellFrame.m
//  SianWeibo
//
//  Created by yusian on 14-4-25.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Cell根父类框架模型

#import "SABaseTextCellFrame.h"
#import "SABaseText.h"

@implementation SABaseTextCellFrame

#pragma mark - 设置数据模型计算框架模型（头像大小默认为small）
-(void)setDataModel:(SABaseText *)dataModel
{
    _dataModel = dataModel;
    CGSize screenSize = [UIScreen mainScreen].applicationFrame.size;
    _cellWidth = screenSize.width - 2 * kCellMargins;
    
    // 1、设置头像尺寸位置；
    CGFloat avataX = kInterval;
    CGFloat avataY = kInterval;
    _avataRect = (CGRect){{avataX, avataY}, [SAAvata sizeOfAvataType:_avataType]};
    
    // 2、设置昵称尺寸位置；
    CGFloat screenNameX = CGRectGetMaxX(_avataRect) + kInterval;
    CGFloat screenNameY = avataY;
    CGSize screenNameSize = [dataModel.user.screenName sizeWithFont:kScreenNameFount];
    _screenNameRect = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    // 3、设置会员图标尺寸位置
    CGFloat mbIconX = CGRectGetMaxX(_screenNameRect) + kInterval;
    CGFloat mbIconY = (screenNameSize.height - kMBIconWH) * 0.5 + screenNameY;
    _mbIconRect = CGRectMake(mbIconX, mbIconY, kMBIconWH, kMBIconWH);
    
    // 4、默认高度
    _cellHeight = MAX(CGRectGetHeight(_avataRect), CGRectGetHeight(_screenNameRect)) + kInterval;
}

#pragma mark - 根据头像大小设置数据模型计算框架模型
-(void)setDataModel:(SABaseText *)dataModel withAvataType:(SAAvataType)avataType
{
    _avataType = avataType;
    [self setDataModel:dataModel];
}

@end
