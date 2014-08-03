//
//  SAStatusDock.m
//  SianWeibo
//
//  Created by yusian on 14-4-20.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  微博Dock

#import "SAStatusDock.h"
#import "UIImage+SA.h"
#import "NSString+SA.h"

@implementation SAStatusDock

#pragma mark - 1、初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 添加3个按钮
        _reposts = [self addButtonWithImage:@"timeline_icon_comment.png"
                            backgroundImage:@"timeline_card_leftbottom.png" buttonIndex:0];
        
        _comments = [self addButtonWithImage:@"timeline_icon_retweet.png"
                             backgroundImage:@"timeline_card_middlebottom.png" buttonIndex:1];
        
        _attitudes = [self addButtonWithImage:@"timeline_icon_unlike.png"
                              backgroundImage:@"timeline_card_rightbottom.png" buttonIndex:2];

    }
    return self;
}

#pragma mark - 1.1、添加按钮方法
- (UIButton *)addButtonWithImage:(NSString *)imageName backgroundImage:(NSString *)backgroundImageName buttonIndex:(NSInteger)index
{
    UIButton *button = [super addButtonWithImage:imageName backgroundImage:backgroundImageName buttonIndex:index];
    [button setBackgroundImage:[UIImage resizeImage:backgroundImageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizeImage:[backgroundImageName fileAppend:@"_highlighted"]] forState:UIControlStateHighlighted];
    
    // 添加按钮间间隔图片
    if (index) {
        UIImageView *cardButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line.png"]];
        [self addSubview:cardButton];
        cardButton.center = CGPointMake(button.frame.origin.x, kStatusDockHeight * 0.5);
    }
    
    return button;
}


@end
