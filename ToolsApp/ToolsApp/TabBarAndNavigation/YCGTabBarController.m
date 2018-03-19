//
//  YCGTabBarController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGTabBarController.h"
#import "YCGNavigationController.h"
#import "YCGHomeViewController.h"
#import "YCGFindViewController.h"
#import "YCGActivityViewController.h"
#import "YCGMeViewController.h"

@interface YCGTabBarController ()

@end

@implementation YCGTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addAllViewControllers];
    
}



#pragma mark - 添加所有自控制器
- (void)addAllViewControllers
{
    //1
    YCGHomeViewController *homeVC = [[YCGHomeViewController alloc] init];
    [self addChildViewController:homeVC title:@"首页" imageNamed:@"tabBar_home"];
    //2
    YCGActivityViewController *activityVC = [[YCGActivityViewController alloc] init];
    [self addChildViewController:activityVC title:@"活动" imageNamed:@"tabBar_activity"];
    //3
    YCGFindViewController *findVC = [[YCGFindViewController alloc] init];
    [self addChildViewController:findVC title:@"发现" imageNamed:@"tabBar_find"];
    //4
    YCGMeViewController *mineVC = [[YCGMeViewController alloc] init];
    [self addChildViewController:mineVC title:@"我的" imageNamed:@"tabBar_mine"];
    
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    YCGNavigationController *nav = [[YCGNavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
    
    [self addChildViewController:nav];
}



+(void)initialize
{
    //设置UITabBarItem主题
    [self setupTabBarItemTheme];
    
    //设置UITabar主题
    [self setupTabBarTheme];
    
}

#pragma mark - 设置tabbarItem的主题
+(void)setupTabBarItemTheme
{
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    /****设置文字属性****/
    //普通状态颜色为黑色，字体大小12
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    
    //选中状态颜色为橙色，字体大小12
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
    
    //高亮状态
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} forState:UIControlStateHighlighted];
    
    //不可用状态
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} forState:UIControlStateDisabled];
    
}

#pragma mark - 设置tabbarItem的主题
+ (void)setupTabBarTheme
{
    //这里可以更换自定义tabbar
    //[self setValue:[[XMGTabBar alloc] init] forKeyPath:@"tabBar"];}
    
}

@end
