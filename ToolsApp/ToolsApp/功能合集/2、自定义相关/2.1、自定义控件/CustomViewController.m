//
//  CustomViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/22.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSoureArray =@[
                           @{@"title":@"自定义按钮",@"className":@"CustomButtonViewController"},
                           @{@"title":@"自定义标签",@"className":@"CustomLabelViewController"},
                           @{@"title":@"给控件添加光圈",@"className":@"HaloLayerViewController"},
                           @{@"title":@"自定义导航栏",@"className":@"CustomNavigationBarViewController"},
                           ];
}

@end
