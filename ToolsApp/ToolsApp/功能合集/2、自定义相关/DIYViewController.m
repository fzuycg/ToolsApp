//
//  DIYViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/29.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "DIYViewController.h"

@interface DIYViewController ()

@end

@implementation DIYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoureArray =@[
                           @{@"title":@"自定义控件",@"className":@"CustomViewController"},
                           @{@"title":@"自定义弹出视图",@"className":@"DIYPopViewController"},
                           ];
}

@end
