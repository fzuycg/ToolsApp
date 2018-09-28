//
//  CustomButtonViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CustomButtonViewController.h"

@interface CustomButtonViewController ()

@end

@implementation CustomButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSoureArray =@[
                           @{@"title":@"悬浮按钮",@"className":@"SuspensionButtonViewController"},
                           @{@"title":@"倒计时按钮",@"className":@"CountDownButtonViewController"},
                           ];
}

@end
