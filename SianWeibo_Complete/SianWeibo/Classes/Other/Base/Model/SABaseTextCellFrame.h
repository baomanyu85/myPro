//
//  SABaseTextCellFrame.h
//  SianWeibo
//
//  Created by yusian on 14-4-25.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  Cell根父类框架模型

#import <Foundation/Foundation.h>
#import "SAAvata.h"
@class SABaseText;

@interface SABaseTextCellFrame : NSObject

@property (nonatomic, readonly) CGRect      avataRect;      // 头像
@property (nonatomic, readonly) CGRect      screenNameRect; // 昵称
@property (nonatomic, readonly) CGRect      mbIconRect;     // 会员图标
@property (nonatomic, assign)   CGRect      timeRect;       // 时间
@property (nonatomic, assign)   CGRect      sourceRect;     // 来源
@property (nonatomic, assign)   CGRect      textRect;       // 正文
@property (nonatomic, assign)   CGFloat     cellHeight;     // 行高
@property (nonatomic, readonly) CGFloat     cellWidth;      // 行宽
@property (nonatomic, assign)   SAAvataType avataType;      // 头像类型
@property (nonatomic, strong)   SABaseText  *dataModel;     // 数据模型

-(void)setDataModel:(SABaseText *)dataModel withAvataType:(SAAvataType)avataType;

@end
