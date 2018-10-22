//
//  MarkdownViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/10.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MarkdownViewController.h"


@interface MarkdownViewController ()

@end

@implementation MarkdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, kNavigation_HEIGHT+40, kScreen_width-80, 40)];
    button.backgroundColor = [UIColor brownColor];
    [button setTitle:@"BUTTON" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 7;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)buttonClick:(UIButton *)button {
    
    
    
    
}


@end
