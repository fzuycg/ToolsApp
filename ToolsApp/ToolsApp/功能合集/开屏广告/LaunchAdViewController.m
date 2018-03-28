//
//  LaunchAdViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/19.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "LaunchAdViewController.h"
#import "LaunchAdManager.h"

@interface LaunchAdViewController ()

@end

@implementation LaunchAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[LaunchAdManager shareManager] loadData];
}

@end
