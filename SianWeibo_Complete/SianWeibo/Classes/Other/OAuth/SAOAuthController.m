//
//  SAOAuthController.m
//  SianWeibo
//
//  Created by yusian on 14-4-14.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//

#import "SAOAuthController.h"
#import "SAHttpTool.h"
#import "SAAccountTool.h"
#import "SAMainController.h"
#import "MBProgressHUD.h"

@interface SAOAuthController () <UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation SAOAuthController

#pragma mark 设置WebView为主View
-(void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = _webView;
    _webView.delegate = self;
}

#pragma mark 加载web数据到View
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1 拼接请求授权的URL
    NSString *requestRULString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=mobile", kOAuthURL, kAppKey, kRedirect_uri];
    NSURL *url = [NSURL URLWithString:requestRULString];
    
    // 2 将请求的页面加载到WebView
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark 代理方法获取Token
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1、获取全路径，将URL转换成字符串
    NSString *url = request.URL.absoluteString;
    
    // 2、查找code范围
    NSRange range = [url rangeOfString:@"code="];       // 匹配包含"code="的URL
    if (range.length){                                  // 如果有，取"code="后跟的串，即为requestToken
        NSInteger index = range.location + range.length;
        NSString *requestToken = [url substringFromIndex:index];
        
    // 3、换取accessToken
        [self getAccessToken:requestToken];
        
        return NO;
    }
    return YES;
}

-(void)getAccessToken:(NSString *)requestToken
{
    // SAHttpTool类中自定义方法，实为封装AFNetWorking的方法获取网页数据
    [SAHttpTool httpToolPostWithBaseURL:kBaseURL path:@"oauth2/access_token" params:
     @{
       // 新浪要求必须传递的五个参数
       @"client_id" : kAppKey,
       @"client_secret" : kAppSecret,
       @"grant_type" : @"authorization_code",
       @"code" : requestToken,
       @"redirect_uri" : kRedirect_uri
       
       // 成功获取JSON
       } success:^(id JSON) {
           
           // 1 将JSON转换成数据模型并归档
           SAAccount *account = [SAAccount accountWithDict:JSON];
           [[SAAccountTool sharedAccountTool] saveAccount:account];
           
           // 2 跳转到主页面
           self.view.window.rootViewController = [[SAMainController alloc]init];
           // MyLog(@"%@", JSON);
           
           // 3 清除页面加载提示
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           
       // 获取信息失败
       } failure:^(NSError *error) {
           
           // 1 打印错误提示
           MyLog(@"OAuth认证请求失败-%@", [error localizedDescription]);
           
           // 2 清除页面加载提示
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       } method:@"POST"];
}

#pragma mark - webView的两个代理方法
#pragma mark 开始加载页面时调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 引入第三方框架"MBProgressHUD"添加页面加载提示
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:webView animated:YES];
    hud.labelText = @"小龙虾加油中...";                    // 设置文字
    hud.labelFont = [UIFont systemFontOfSize:14];
}

#pragma mark 页面加载完毕后调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 清除页面加载提示
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
}

@end
