//
//  AnimationAboutViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/9.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "AnimationAboutViewController.h"

@interface AnimationAboutViewController ()

@end

@implementation AnimationAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoureArray =@[
                           @{@"title":@"基础动画",@"className":@"BaseAnimationViewController"},
                           @{@"title":@"转场动画",@"className":@""},
                           ];
}

@end
