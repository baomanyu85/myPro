//
//  SANewfeatureController.m
//  SianWeibo
//
//  Created by yusian on 14-4-10.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  版本新特性控制器

#import "SANewfeatureController.h"
#import "UIImage+SA.h"
#import "SAMainController.h"
#import "SAAccountTool.h"
#import "SAOAuthController.h"
#define kPicCount 4
#define kPageControlW 150

@interface SANewfeatureController () <UIScrollViewDelegate>
{
    UIPageControl   *_pageControl;
    CGSize          _size;
}

@end

@implementation SANewfeatureController

#pragma mark - 1、初始化
#pragma mark 1.1、自定义view
- (void)loadView
{
    // self.view直接使用UIImageView设置ImageView尺寸与位置
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage fullScreenImage:@"new_feature_background.png"];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.userInteractionEnabled = YES;                 // 开启当前控件与用户交互
    self.view = imageView;                                  // 基本View设置为新创建ImageView
}

#pragma mark 1.2、视图加载完毕后调用
- (void)viewDidLoad
{
    [super viewDidLoad];
    _size = [UIScreen mainScreen].bounds.size;              // 全局定义一个屏幕宽高值供后续使用
    UIScrollView *scrollView = [self creatScrollView];      // 创建一个scrollView
    UIPageControl *pageControl = [self creatPageControl];   // 创建一个pageControl
    
    [self.view addSubview:pageControl];                     // pageControl加载到视图
    [self.view addSubview:scrollView];                      // scrollView加载到视图
}

#pragma mark - 2、添加子控件
#pragma mark 2.1、添加scrollView控件
- (UIScrollView *)creatScrollView       // 控件的创建单独抽象成方法
{
    // 创建scrollView设置尺寸位置及相关属性
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(_size.width * kPicCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //  创建新特性图片设置尺寸位置并添加到scrollView
    for (int i = 0; i < kPicCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [scrollView addSubview:imageView];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d.png", i + 1];
        imageView.image = [UIImage fullScreenImage:imageName];
        imageView.frame = CGRectMake(_size.width * i, 0, _size.width, _size.height);
        // 最后一张图片上添加两个子视图（分享选项与体验微博按钮）
        if ( i == kPicCount - 1) {
            imageView.userInteractionEnabled = YES;         // 开启当前imageView用户交互属性
            [self addShareButton:imageView];                // 调用方法创建分享选项视图
            [self addStartButton:imageView];                // 调用方法创建体验微博按钮视图
        }
    }
    return scrollView;
}

#pragma mark 2.2、添加pageControl控件
- (UIPageControl *)creatPageControl     // 控件的创建单独抽象成方法
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(_size.width * 0.5, _size.height * 0.95);
    pageControl.bounds = CGRectMake(0, 0, kPageControlW, 0);
    pageControl.numberOfPages = kPicCount;
    
    // pageControl指示符颜色用图片代替，效果更美观
    UIImage *checkedPointImage = [UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:checkedPointImage];
    UIImage *pointImage = [UIImage imageNamed:@"new_feature_pagecontrol_point.png"];
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:pointImage];
    
    // scrollView的代理方法中可设置pageControl的当前页属性，将创建好的pageControl赋值给成员变量全局访问
    _pageControl = pageControl;
    return pageControl;
}

#pragma mark - 2.3、添加末尾页按钮
#pragma mark 2.3.1、分享按钮添加
- (void)addShareButton:(UIImageView *)imageView         // 新特性展示最后一张图片中"分享"视图单独抽象成方法
{
    // 用按钮来实现"分享"视图
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.adjustsImageWhenHighlighted = NO;       // 去除按钮的高亮效果
    
    // 设置按钮两个状态，循环点击时循环切换
    UIImage *shareNomalImage = [UIImage imageNamed:@"new_feature_share_false.png"];
    UIImage *shareSelectedImage = [UIImage imageNamed:@"new_feature_share_true.png"];
    [shareButton setBackgroundImage:shareNomalImage forState:UIControlStateNormal];
    [shareButton setBackgroundImage:shareSelectedImage forState:UIControlStateSelected];
    
    // 设置按钮尺寸位置
    shareButton.center = CGPointMake(_size.width * 0.5, _size.height * 0.7);
    CGSize shareBtnSize = shareNomalImage.size;
    shareButton.bounds = CGRectMake(0, 0, shareBtnSize.width, shareBtnSize.height);
    shareButton.selected = YES;                         // 默认为已选择状态
    
    // 创建按钮监听事件，每次点击都修改一次selected状态
    [shareButton addTarget:self action:@selector(shareButtonEven:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareButton];
}

#pragma mark 2.3.2、立即体验按钮添加
- (void)addStartButton:(UIImageView *)imageView         // 新特性展示最后一张图片中"体验"按钮单独抽象成方法
{
    // 创建按钮，设置尺寸宽高等属性
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *startNomalImage = [UIImage imageNamed:@"new_feature_finish_button.png"];
    UIImage *startHighlightImage = [UIImage imageNamed:@"new_feature_finish_button_highlighted.png"];
    [startButton setBackgroundImage:startNomalImage forState:UIControlStateNormal];
    [startButton setBackgroundImage:startHighlightImage forState:UIControlStateHighlighted];
    startButton.center = CGPointMake(_size.width * 0.5, _size.height * 0.8);
    CGSize startBtnSize = startNomalImage.size;
    startButton.bounds = (CGRect){CGPointZero, startBtnSize};
    
    // 按钮监听事件，点击该按钮进入微博主界面
    [startButton addTarget:self action:@selector(startButtonEven:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];

}

#pragma mark - 3、按钮事件处理方法
#pragma mark 3.1分享按钮事件处理
-(void)shareButtonEven:(UIButton *)button               // "分享"按钮事件处理
{
    button.selected = !button.selected;
    // 按钮的selected属性取反，实现循环点击-选择或取消分享
}

#pragma mark 3.2、立即体验按钮事件处理
-(void)startButtonEven:(UIButton *)button               // "体验"按钮事件处理
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 该按钮事件使程序切换到微博主界面
    if ([[SAAccountTool sharedAccountTool] account]){
        self.view.window.rootViewController = [[SAMainController alloc] init];
    } else {
        self.view.window.rootViewController = [[SAOAuthController alloc] init];
    }
}

#pragma mark - 4、scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView   // 利用代理方法计算出pageControl中当前当前页属性
{
    _pageControl.currentPage =  scrollView.contentOffset.x / scrollView.frame.size.width;
    // contentOffset.x的值除以视图宽度得到的整数相当于当前的页码
}

@end