//
//  TopMenuViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "TopMenuViewController.h"

@interface TopMenuViewController ()

@end

@implementation TopMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 120, 80, 40)];
    [closeBtn setTitle:@"close" forState:UIControlStateNormal];
    closeBtn.backgroundColor = [UIColor blueColor];
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

- (void)closeBtnAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
