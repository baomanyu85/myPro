//
//  SASendController.m
//  SianWeibo
//
//  Created by yusian on 14-5-6.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SASendController.h"
#import "UIImage+SA.h"
#import "SAStatusTool.h"
#import "SAHomeController.h"

@interface SASendController () <UITextViewDelegate>
{
    UITextView  *_textView;
}
@end

@implementation SASendController

#pragma mark 初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 基本设置
        self.title = @"发送微博";
        self.view.backgroundColor = [UIColor whiteColor];
        
        // 创建文本输入框
        UITextView *textView = [[UITextView alloc] init];
        CGFloat textViewY = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? 74 : 10;
        textView.frame = CGRectMake(kInterval, textViewY, 300, 100);
        textView.backgroundColor = kBGColor;
        textView.delegate = self;
        textView.font = [UIFont systemFontOfSize:14];
        textView.text = @"微博内容不超过140个汉字";
        textView.textColor = [UIColor lightGrayColor];
        _textView = textView;
        
        // 创建发送按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonY = CGRectGetMaxY(textView.frame);
        button.frame = CGRectMake(kInterval, buttonY + kInterval, 300, 44);
        [button setTitle:@"发送" forState:UIControlStateNormal];
        UIImage *normalImage = [UIImage resizeImage:@"common_card_background.png"];
        UIImage *highLightImage = [UIImage resizeImage:@"common_card_background_highlighted.png"];
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
        [button setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendStatus) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        [self.view addSubview:textView];
        [textView becomeFirstResponder];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark 微博发送事件
- (void)sendStatus
{
    // 获取文本输入框内容
    NSString *statusText = _textView.text;
    
    // 发送微博
    [SAStatusTool statusToolSendStatus:statusText];
    
    // 返回首页控制器
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = nil;
    
    textView.textColor = [UIColor blackColor];
}

@end
