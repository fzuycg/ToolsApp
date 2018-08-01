//
//  MenuFunctionViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MenuFunctionViewController.h"

@interface MenuFunctionViewController ()

@end

@implementation MenuFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoureArray =@[
                           @{@"title":@"侧滑菜单(弹簧)",@"className":@"LeftSpringMenuViewController"},
                           @{@"title":@"侧滑菜单(正常)",@"className":@"LeftMenuViewController"},
                           @{@"title":@"下拉菜单",@"className":@"TopMenuViewController"},
                           @{@"title":@"弹出菜单",@"className":@"PopMenuViewController"},
                           @{@"title":@"支付宝菜单",@"className":@"ALiPayHomeViewController"},
                           ];
}

@end
