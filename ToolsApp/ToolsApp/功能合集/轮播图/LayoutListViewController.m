//
//  LayoutListViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "LayoutListViewController.h"

@interface LayoutListViewController ()

@end

@implementation LayoutListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSoureArray =@[
                           @{@"title":@"卡片切换",@"className":@""},
                           @{@"title":@"瀑布流",@"className":@"WaterFallViewController"},
                           
                           ];
}

@end
