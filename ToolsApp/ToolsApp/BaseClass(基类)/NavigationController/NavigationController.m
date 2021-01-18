//
//  NavigationController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController () <UIGestureRecognizerDelegate>

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
}

+(void)initialize
{
    //设置导航items数据主题
    [self setupNavigationItemsTheme];
    
    //设置导航栏主题
    [self setupNavigationBarTheme];
}

#pragma mark - 设置导航栏数据主题
+(void)setupNavigationItemsTheme
{
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    
    //设置字体颜色
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor],NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateHighlighted];
    
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor]} forState:UIControlStateDisabled];
}

#pragma mark - 设置导航栏主题
+(void)setupNavigationBarTheme
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置导航栏的title属性
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //设置导航栏颜色
    [bar setBarTintColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.8 alpha:1]];
    
    //设置导航栏背景图
//    UIImage *image = [UIImage imageNamed:@"Home-Page"];
//    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
}

#pragma  mark - 拦截所有push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if (self.viewControllers.count > 0) {
//        // 如果navigationController的字控制器个数大于两个就隐藏，底部工具栏
//        viewController.hidesBottomBarWhenPushed = YES;
//
//        //设置返回按钮
////        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
//
//        //修改返回文字
//        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
//        //全部修改返回按钮,但是会失去右滑返回的手势
//        if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >=1) {
//
//            viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
//        }
//    }
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

-(UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_item_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}


/**
 *  点击返回按钮时调用
 *  返回上一个界面
 */
-(void)back
{
    [super popViewControllerAnimated:YES];
    
}

/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *
 *  @return YES : 手势有效, NO : 手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}

@end
