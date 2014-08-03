//
//  SAAvata.h
//  SianWeibo
//
//  Created by yusian on 14-4-19.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  用户头像处理类

#import <UIKit/UIKit.h>
#import "SAUser.h"

typedef enum {
    
    kAvataTypeSmall,    // 小图标：36 * 36
    kAvataTypeDefault,  // 中图标：50 * 50
    kAvataTypeBig       // 大图标：85 * 85
    
} SAAvataType;

@interface SAAvata : UIView

@property (nonatomic, assign) SAAvataType   type;
@property (nonatomic, strong) SAUser        *user;

+ (CGSize)sizeOfAvataType:(SAAvataType)avataType;
- (void)setUser:(SAUser *)user ofType:(SAAvataType)type;
- (UIImage *)placeImageWithAvataType:(SAAvataType)avataType;

@end
