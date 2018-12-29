//
//  YCGFindViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGFindViewController.h"

@interface YCGFindViewController ()

@end

@implementation YCGFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI {
    UILabel *label_1 = [[UILabel alloc] initWithFrame:CGRectMake(20, kNavigation_HEIGHT+20, kScreen_width-40, 30)];
    label_1.text = @"工农建中";
    label_1.backgroundColor = [UIColor yellowColor];
    label_1.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label_1];
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
