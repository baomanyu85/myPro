//
//  SAMainController.m
//  SianWeibo
//
//  Created by yusian on 14-4-11.
//  Copyright (c) 2014年 小龙虾论坛. All rights reserved.
//  主程序界面

#import "SAMainController.h"
#import "SAHomeController.h"
#import "SAMessageController.h"
#import "SAProfileController.h"
#import "SADiscoverController.h"
#import "SAMoreController.h"
#import "SANavigationController.h"
#import "UIBarButtonItem+SA.h"

@interface SAMainController () <UINavigationControllerDelegate>

@end

@implementation SAMainController

#pragma mark - 1、初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加其他View
    [self addSubView];
    
    // 添加Dock控件元素
    [self addDockItems];
    
}

#pragma mark 1.1、添加控制器
- (void)addSubView
{
    // 添加"首页"视图
    SAHomeController *homeControl = [[SAHomeController alloc] init];
    SANavigationController *homeNav = [[SANavigationController alloc] initWithRootViewController:homeControl];
    homeNav.delegate = self;
    [self addChildViewController:homeNav];
    
    // 添加"消息"视图
    SAMessageController *messageControl = [[SAMessageController alloc] initWithStyle:UITableViewStyleGrouped];
    SANavigationController *messageNav = [[SANavigationController alloc] initWithRootViewController:messageControl];
    messageNav.delegate = self;
    [self addChildViewController:messageNav];
    
    // 添加"我"视图
    SAProfileController *profileControl = [[SAProfileController alloc] init];
    SANavigationController *profileNav = [[SANavigationController alloc] initWithRootViewController:profileControl];
    profileNav.delegate = self;
    [self addChildViewController:profileNav];
    
    // 添加"广场"视图
    SADiscoverController *discoverControl = [[SADiscoverController alloc] init];
    SANavigationController *discoverNav = [[SANavigationController alloc] initWithRootViewController:discoverControl];
    discoverNav.delegate = self;
    [self addChildViewController:discoverNav];
    
    // 添加"更多"视图
    SAMoreController *moreControl = [[SAMoreController alloc] initWithStyle:UITableViewStyleGrouped];
    SANavigationController *moreNav = [[SANavigationController alloc] initWithRootViewController:moreControl];
    moreNav.delegate = self;
    [self addChildViewController:moreNav];
}

#pragma mark 1.2、添加Dock
- (void)addDockItems
{
    [self.dock addItemWithIcon:@"tabbar_home.png" selectedIcon:@"tabbar_home_selected.png" title:@"首页"];
    [self.dock addItemWithIcon:@"tabbar_message_center.png" selectedIcon:@"tabbar_message_center_selected.png" title:@"消息"];
    [self.dock addItemWithIcon:@"tabbar_profile.png" selectedIcon:@"tabbar_profile_selected.png" title:@"我"];
    [self.dock addItemWithIcon:@"tabbar_discover.png" selectedIcon:@"tabbar_discover_selected.png" title:@"广场"];
    [self.dock addItemWithIcon:@"tabbar_more.png" selectedIcon:@"tabbar_more_selected.png" title:@"更多"];
    
}

#pragma mark - 2、按钮事件处理
#pragma mark - 2.1、Dock按钮事件
- (void)clickWithDockButtonIndex:(NSUInteger)index
{
    // 取到首页控制器
    SAHomeController *homeController = [[[self.childViewControllers firstObject] childViewControllers] firstObject];
    
    // 调用首页控制器的刷新方法
    if ([homeController respondsToSelector:@selector(refresh)]) [homeController refresh];
}
#pragma mark 2.2、导航条按钮事件
- (void)back
{
    // 利用Dock传过来的Dock序号(0 - 5)，来确定当前需要操作的导航控制器，从而在当前控制器的子控制器数据组找到对应的导航控制器，弹出栈顶控制器
    [self.childViewControllers[self.dock.indexSelected] popViewControllerAnimated:YES];
}

#pragma mark - 3、代理方法实现
#pragma mark - 3.1、即将展示下一控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 从首页控制器内部切换需要调整控制器的高度及Dock栏的归属
    UIViewController *rootViewController = [navigationController.viewControllers firstObject];
    
    // 如果从根控制器切换到其他控制器需要把Dock栏移走，并调整切换后的控制器高度
    if (viewController != rootViewController) {
        
        // 1、调整控制器高度
        CGRect naConViewFrame = navigationController.view.frame;
        CGFloat naConY = navigationController.navigationBar.frame.origin.y;
        CGFloat appHeight = [UIScreen mainScreen].applicationFrame.size.height;
        naConViewFrame.size.height = appHeight + naConY;
        navigationController.view.frame = naConViewFrame;
        
        // 2、新控制器添加按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_back.png" highLightedImageName:@"navigationbar_back_highlight.png" addTarget:self action:@selector(back)];
        
        // 3、计算Dock的y值变化
        CGRect dockFrame = self.dock.frame;
        CGFloat AppHeight = [UIScreen mainScreen].applicationFrame.size.height;
        CGFloat navBarHeight = navigationController.navigationBar.frame.size.height;
        
        // 3.1 Dock的y值为应用程序的高度(460)-导航条高度-Dock自身的高度，考虑到ios7兼容性问题，这里不利用View自身的高度
        dockFrame.origin.y = AppHeight - navBarHeight - kDockHeight;
        
        // 3.2 TableView滚动后，View的y值发生变量，因此Dock的Y值也需要一起调整
        if ([rootViewController.view isKindOfClass:[UIScrollView class]]) {
        
            // 3.2.1 计算滚动的长度，y值自加该长度
            UIScrollView *scrollView = (UIScrollView *)rootViewController.view;
            CGFloat contentY = scrollView.contentOffset.y;
            
            // 3.2.2 ios下透明导航条特性，使得contentOffset自动往下移了64个像素(导航条高度+系统状态栏高度)
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) contentY +=64;
            dockFrame.origin.y += contentY;
        }
        
        // 4、调整Dock的位置
        [self.dock removeFromSuperview];
        self.dock.frame = dockFrame;
        [rootViewController.view addSubview:self.dock];
    }
    
}

#pragma mark 3.2、新控制器展示完毕
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIViewController *rootViewController = [navigationController.viewControllers firstObject];
    // 如果切回到根控制器
    if (viewController == rootViewController) {
        
        // 1、把Dock栏返回给主控制器，并调整Dock的位置
        [self.dock removeFromSuperview];
        [self.view addSubview:self.dock];
        CGRect dockFrame = self.dock.frame;
        dockFrame.origin.y = self.view.frame.size.height - kDockHeight;
        self.dock.frame = dockFrame;
        
        // 2、调整控制器View高度
        CGRect naConViewFrame = navigationController.view.frame;
        CGFloat naConY = navigationController.navigationBar.frame.origin.y;
        CGFloat appHeight = [UIScreen mainScreen].applicationFrame.size.height;
        naConViewFrame.size.height = appHeight + naConY - kDockHeight;
        navigationController.view.frame = naConViewFrame;
        
    }
}



@end
