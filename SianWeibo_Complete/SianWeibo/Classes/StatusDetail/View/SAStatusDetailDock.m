//
//  SAStatusDetailDock.m
//  SianWeibo
//
//  Created by yusian on 14-4-24.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAStatusDetailDock.h"
#import "SAStatus.h"
#import "UIImage+SA.h"
#define kDockMargins 5

@interface SAStatusDetailDock()
{
    UIButton    *_comments;     // 评论
    UIButton    *_reporsts;     // 转发
    UIButton    *_attitudes;    // 点赞
    UIButton    *_selected;     // 临时按钮
    UIImageView *_bgView;       // 背景视图
    UIImageView *_arrow;        // 箭头指示
}
@end

@implementation SAStatusDetailDock

#pragma mark - 1、初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1、设置基本视图，添加背景View
        self.bounds = CGRectMake(0, 0, kDetailDockW, kDetailDockH);
        self.backgroundColor = kBGColor;
        CGFloat screenWidth = [UIScreen mainScreen].applicationFrame.size.width;
        CGFloat bgViewHeight = kDetailDockH - kDockMargins;
        CGFloat bgViewWidth = self.frame.size.width - 2 * kCellMargins;
        _bgView = [[UIImageView alloc] initWithImage:[UIImage resizeImage:@"common_card_top_background.png"]];
        _bgView.frame = CGRectMake((screenWidth - bgViewWidth) * 0.5, kDockMargins, bgViewWidth, bgViewHeight);
        _bgView.userInteractionEnabled = YES;
        [self addSubview:_bgView];
        
        // 2、背景View添加子控件
        // 2.1 添加分隔线
        UIImageView *buttonline = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line.png"]];
        buttonline.center = CGPointMake(bgViewWidth / 4, bgViewHeight / 2);
        [_bgView addSubview:buttonline];

        // 2.2 添加指示箭头
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"statusdetail_comment_top_arrow.png"]];
        _arrow.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [_bgView addSubview:_arrow];
        
        // 2.3 添加三个按钮，并且让第一个按钮触发按钮事件
        _reporsts = [self creatButtonWithIndex:0];
        _comments = [self creatButtonWithIndex:1];
        _attitudes = [self creatButtonWithIndex:3];
        _attitudes.enabled = NO;
        [self clickButton:_comments];
    }
    return self;
}

#pragma mark 1.1、创建按钮方法
- (UIButton *)creatButtonWithIndex:(NSUInteger)index
{
    CGFloat width = _bgView.frame.size.width;
    CGFloat height = _bgView.frame.size.height;
    // 初始化
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(index * width / 4, 0, width / 4, height);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置文字状态
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    // 设置事件监听方法
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    button.tag = index + 1;
    
    // 添加到父控件，返回按钮
    [_bgView addSubview:button];
    return button;
}

#pragma mark - 2、设置数据模型
-(void)setStatus:(SAStatus *)status
{
    _status = status;
    
    // 成员变量赋值时设置按钮数据
    [_reporsts setTitle:[NSString stringWithFormat:@"%@ 转发", [self numberTranslate:_status.repostsCount]] forState:UIControlStateNormal];
    [_reporsts setTitle:[NSString stringWithFormat:@"%@ 转发", [self numberTranslate:_status.repostsCount]] forState:UIControlStateSelected];
    [_comments setTitle:[NSString stringWithFormat:@"%@ 评论", [self numberTranslate:_status.commentsCount]] forState:UIControlStateNormal];
    [_comments setTitle:[NSString stringWithFormat:@"%@ 评论", [self numberTranslate:_status.commentsCount]] forState:UIControlStateSelected];
    [_attitudes setTitle:[NSString stringWithFormat:@"%@ 赞", [self numberTranslate:_status.attitudesCount]] forState:UIControlStateNormal];
    [_attitudes setTitle:[NSString stringWithFormat:@"%@ 赞", [self numberTranslate:_status.attitudesCount]] forState:UIControlStateSelected];
}

#pragma mark 2.1、数字转换方法
- (NSString *)numberTranslate:(NSUInteger)number
{
    NSString *numberStr;
    if (number > 10000) {       // 一万条以上数据简约显示如:1.3万
        numberStr = [NSString stringWithFormat:@"%.1f万", number / 10000.0];
        numberStr = [numberStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else {                    // 一万条以下数据直接显示实际数值
        numberStr = [NSString stringWithFormat:@"%d", (int)number];
    }
    return numberStr;
}

#pragma mark - 3、按钮事件处理
- (void)clickButton:(UIButton *)button
{
    // 1、设置状态三步曲：取消、添加、替换
    _selected.selected = NO;
    button.selected = YES;
    _selected = button;
    
    // 2、设置箭头指示符动画
    CGFloat width = _bgView.frame.size.width;
    CGFloat height = _bgView.frame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        _arrow.center = CGPointMake((button.tag - 0.5 )* width / 4, height - _arrow.image.size.height / 2);}];
    
    // 3、通知代理
    if ([_delegate respondsToSelector:@selector(statusDetailDock:clickButton:)]) {
        
        if (button == _comments) {          // 评论按钮
            
            [_delegate statusDetailDock:self clickButton:(kStatusDetailDockButtonTypeComments)];
            
        } else if (button == _reporsts) {   // 转发按钮
            
            [_delegate statusDetailDock:self clickButton:(kStatusDetailDockButtonTypeResports)];
            
        } else if (button == _attitudes) {  // 点赞按钮
            
            [_delegate statusDetailDock:self clickButton:(kStatusDetailDockButtonTypeAttitudes)];
            
        }
        
    }
}

@end
