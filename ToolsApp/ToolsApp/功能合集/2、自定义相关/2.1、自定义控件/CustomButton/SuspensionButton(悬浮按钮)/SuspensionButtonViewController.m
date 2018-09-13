//
//  SuspensionButtonViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "SuspensionButtonViewController.h"
#import "SuspensionButton.h"

@interface SuspensionButtonViewController ()<SuspensionButtonDelegate>

@end

@implementation SuspensionButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI {
    SuspensionButton *btn = [[SuspensionButton alloc] initWithFrame:CGRectMake(kScreen_width-50-10, kScreen_height-kTabBar_height-50, 50, 50)];
    [btn setButtonImage:[UIImage imageNamed:@"悬浮按钮.png"]];
    [btn setButtonEdge:12];
    btn.delegate = self;
    
    [self.view addSubview:btn];
}

#pragma mark - SuspensionButtonDelegate
- (void)suspensionButtonClick {
    NSLog(@"点击了悬浮按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
