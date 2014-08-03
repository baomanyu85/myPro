//
//  SABaseDock.h
//  SianWeibo
//
//  Created by yusian on 14-4-23.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SAStatus;
@interface SABaseDock : UIImageView
{
    UIButton    *_reposts;
    UIButton    *_comments;
    UIButton    *_attitudes;
    SAStatus    *_status;
}

@property (nonatomic, strong) SAStatus *status;

- (UIButton *)addButtonWithImage:(NSString *)imageName backgroundImage:(NSString *)backgroundImageName buttonIndex:(NSInteger)index;

- (void)setButton:(UIButton *)button withTitle:(NSString *)title forCounts:(NSUInteger)number;

@end
