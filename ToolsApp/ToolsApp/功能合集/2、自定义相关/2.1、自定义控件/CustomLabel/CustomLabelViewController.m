//
//  CustomLabelViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/22.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CustomLabelViewController.h"

@interface CustomLabelViewController ()

@end

@implementation CustomLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSoureArray =@[
                           @{@"title":@"打印机",@"className":@"PrintLabelViewController"},
                           @{@"title":@"跑马灯",@"className":@"MarqueeLabelViewController"},
                           ];
}

@end
