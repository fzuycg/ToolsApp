//
//  YCGHomeViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGHomeViewController.h"

@interface YCGHomeViewController ()

@end

@implementation YCGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // navigationbar透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 去掉下面的线条
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.navigationItem.title = @"功能模块";
    
    self.dataSoureArray =@[
                           @{@"title":@"1、启动相关",@"className":@"LaunchViewController"},
                           @{@"title":@"2、自定义相关",@"className":@"DIYViewController"},
                           @{@"title":@"3、视图布局",@"className":@"LayoutListViewController"},
                           @{@"title":@"4、系统功能",@"className":@"SystemFunctionViewController"},
                           @{@"title":@"5、动画相关",@"className":@"AnimationAboutViewController"},
                           @{@"title":@"6、选择器",@"className":@"SelectorViewController"},
                           @{@"title":@"7、其他功能",@"className":@"OtherFunctionViewController"},
                           @{@"title":@"8、菜单",@"className":@"MenuFunctionViewController"},
                           @{@"title":@"浏览器",@"className":@"WebBrowserViewController"},
                           ];
}

@end
