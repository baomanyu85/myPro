//
//  SADetailRetweetDock.m
//  SianWeibo
//
//  Created by yusian on 14-4-23.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SADetailRetweetDock.h"
#import "UIImage+SA.h"
#import "SAStatus.h"

@implementation SADetailRetweetDock

#pragma mark - 1、初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1、设置Frame并设置自动伸缩属性Dock贴紧父控件右下角
        self.frame = CGRectMake( -(kDetailReDockW + kInterval), -(kDetailReDockH + kInterval), kDetailReDockW, kDetailReDockH);
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        // 2、添加3个按钮
        _reposts = [self addButtonWithImage:@"timeline_icon_comment.png"
                            backgroundImage:@"timeline_card_leftbottom.png" buttonIndex:0];
        
        _comments = [self addButtonWithImage:@"timeline_icon_retweet.png"
                             backgroundImage:@"timeline_card_middlebottom.png" buttonIndex:1];
        
        _attitudes = [self addButtonWithImage:@"timeline_icon_unlike.png"
                              backgroundImage:@"timeline_card_rightbottom.png" buttonIndex:2];
    }
    return self;
}

#pragma mark 1.1、添加子控件方法
-(UIButton *)addButtonWithImage:(NSString *)imageName backgroundImage:(NSString *)backgroundImageName buttonIndex:(NSInteger)index
{
    UIButton *button = [super addButtonWithImage:imageName backgroundImage:backgroundImageName buttonIndex:index];
    [button setBackgroundImage:[UIImage resizeImage:@"common_card_background_highlighted.png"] forState:UIControlStateHighlighted];
    return button;
}

@end
