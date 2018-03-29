//
//  LaunchNoticeViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/28.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "LaunchNoticeViewController.h"
#import "HubMessageView.h"

@interface LaunchNoticeViewController ()

@end

@implementation LaunchNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [HubMessageView showMessage:@"敬请期待新功能"];
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
