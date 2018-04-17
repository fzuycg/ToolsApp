//
//  LeftMenuViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SideMenuViewController.h"
#import "MenuContentViewController.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MenuContentViewController *leftVC =[[MenuContentViewController alloc]init];
    UIViewController *mainVC =[[UIViewController alloc]init];
    SideMenuViewController *slideVC =[SideMenuViewController initWithLeftVC:leftVC mainVC:mainVC];
    
//    [self.navigationController pushViewController:slideVC animated:YES];
}

@end
