//
//  SelectorViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "SelectorViewController.h"

@interface SelectorViewController ()

@end

@implementation SelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoureArray =@[
                           @{@"title":@"城市选择(仿美团)",@"className":@"CitySelectorViewController"},
                           @{@"title":@"城市选择(联动)",@"className":@"CitySelectorPickerViewController"},
                           ];
}

@end
