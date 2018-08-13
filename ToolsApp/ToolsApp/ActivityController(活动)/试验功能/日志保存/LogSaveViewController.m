//
//  LogSaveViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/10.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "LogSaveViewController.h"
#import "LogManager.h"

@interface LogSaveViewController ()

@end

@implementation LogSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日志保存";
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createUI];
}

- (void)createUI {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-120)/2, 100, 120, 40)];
    [btn1 setTitle:@"日志" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-120)/2, 160, 120, 40)];
    [btn2 setTitle:@"线程日志" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-160)/2, 220, 160, 40)];
    [btn3 setTitle:@"未捕获异常崩溃" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-120)/2, 280, 120, 40)];
    [btn4 setTitle:@"清空日志" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)btn1Click {
    NSLog(@"打印日志");
}

- (void)btn2Click {
}

- (void)btn3Click {
    NSLog(@"我的名字:%@", @"小明");
}

- (void)btn4Click {
}

@end
