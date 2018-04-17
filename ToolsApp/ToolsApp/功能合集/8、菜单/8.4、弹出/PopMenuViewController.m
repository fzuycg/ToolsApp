//
//  PopMenuViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "PopMenuViewController.h"
#import "PopMenuManager.h"
#import "PopMenuModel.h"

@interface PopMenuViewController ()

@end

@implementation PopMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_width-120-40, 120, 120, 44)];
    btn.layer.cornerRadius = 8;
    [btn setTitle:@"打开菜单" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(PopMenuClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)PopMenuClik:(id)sender {
    
    NSMutableArray *obj = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self titles].count; i++) {
        
        PopMenuModel * info = [PopMenuModel new];
        info.image = [self images][i];
        info.title = [self titles][i];
        [obj addObject:info];
    }
    
    [[PopMenuManager sharedInstance] showPopMenuSelecteWithFrame:CGRectMake(kScreen_width-120-60, 120+44, 160, 240)
                                                            item:obj
                                                          action:^(NSInteger index)
    {
        NSLog(@"index:%ld",(long)index);
        
    }];
}

- (NSArray *) titles {
    return @[@"扫一扫",
             @"加好友",
             @"创建讨论组",
             @"发送到电脑",
             @"面对面快传",
             @"收钱"];
}

- (NSArray *) images {
    return @[@"right_menu_QR@3x",
             @"right_menu_addFri@3x",
             @"right_menu_multichat@3x",
             @"right_menu_sendFile@3x",
             @"right_menu_facetoface@3x",
             @"right_menu_payMoney@3x"];
}


@end
