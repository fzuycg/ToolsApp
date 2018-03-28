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
    
    self.dataSoureArray =@[
                           //用于测试的页面
                           @{@"title":@"引导页面",@"className":@"GuidePageViewController"},
                           @{@"title":@"开屏广告",@"className":@"LaunchAdViewController"},
                           @{@"title":@"基本动画",@"className":@""},
                           @{@"title":@"视图布局",@"className":@"LayoutListViewController"},
                           @{@"title":@"启动通知",@"className":@""},
                           @{@"title":@"自定义控件",@"className":@"CustomViewController"},
                           @{@"title":@"浏览器",@"className":@"WebBrowserViewController"},
                           ];
}

@end
