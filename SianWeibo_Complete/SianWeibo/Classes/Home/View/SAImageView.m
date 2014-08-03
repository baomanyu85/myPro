//
//  SAImageView.m
//  SianWeibo
//
//  Created by yusian on 14-4-20.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAImageView.h"
#import "SAStatusTool.h"

@interface SAImageView()
{
    UIImageView *_gifView;
}
@end

@implementation SAImageView

#pragma mark - 1、初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 添加Gif图标
        _gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif.png"]];
        
        [self addSubview:_gifView];
        
    }
    return self;
}

#pragma mark 2、添加Gif图标
-(void)setPicUrl:(NSString *)picUrl
{
    _picUrl = picUrl;
    
    [SAStatusTool statusToolInsteadView:self setImageWithURLString:picUrl placeholderImage:[UIImage imageNamed:@"timeline_image_loading.png"]];
    
    // 在设置图片url同时判断该图是否为GIF图片，如果是则显示Gif图标
    _gifView.hidden = ![picUrl.lowercaseString hasSuffix:@".gif"];
}

#pragma mark 3、设置Gif图标Frame
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    // 设置图片Frame的时候将Gif图标的Frame设置好
    CGSize gifViewSize = _gifView.frame.size;
    _gifView.frame = CGRectMake(frame.size.width - gifViewSize.width, frame.size.height - gifViewSize.height, gifViewSize.width, gifViewSize.height);
}

@end
