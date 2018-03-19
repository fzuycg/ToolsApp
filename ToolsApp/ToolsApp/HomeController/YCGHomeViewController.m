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
                           @{@"title":@"临时页面",@"className":@"JDWifiViewController"},
                           @{@"title":@"视图效果",@"className":@"JDViewListViewController"},
                           
                           ];
}

@end
