//
//  SAStatusDetailDock.h
//  SianWeibo
//
//  Created by yusian on 14-4-24.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SAStatus;
@class SAStatusDetailDock;

// 定义Dock按钮枚举类型
typedef enum {
    
    kStatusDetailDockButtonTypeComments,    // 评论
    kStatusDetailDockButtonTypeResports,    // 转发
    kStatusDetailDockButtonTypeAttitudes    // 点赞
    
} StatusDetailDockButtonType;



// 定义代理协议
@protocol SAStatusDetailDockDelegate <NSObject>

@optional

- (void)statusDetailDock:(SAStatusDetailDock *)statusDetailDock clickButton:(StatusDetailDockButtonType)buttonType;

@end


// 定义类
@interface SAStatusDetailDock : UIView

@property (nonatomic, strong) SAStatus *status;
@property (nonatomic, weak) id<SAStatusDetailDockDelegate> delegate;

@end
