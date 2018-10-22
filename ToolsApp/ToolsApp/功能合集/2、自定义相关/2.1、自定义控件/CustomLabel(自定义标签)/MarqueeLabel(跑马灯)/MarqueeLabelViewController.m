//
//  MarqueeLabelViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/22.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MarqueeLabelViewController.h"
#import "MarqueeLabelView.h"

@interface MarqueeLabelViewController ()

@end

@implementation MarqueeLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MarqueeLabelView *view = [[MarqueeLabelView alloc] initWithFrame:CGRectMake(0,120, kScreen_width, 44) withMessage:@"这是一个长长长长长长长长长长长长长长长长长长长长长长长长长长的跑马灯！"];
    [self.view addSubview:view];
}


@end
