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
    self.title = @"点击屏幕弹出菜单";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    
    NSMutableArray *obj = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self titles].count; i++) {
        
        PopMenuModel * info = [PopMenuModel new];
        info.image = [self images][i];
        info.title = [self titles][i];
        [obj addObject:info];
    }
    
    // 这里传的是 顶点坐标 与 菜单宽高
    struct MenuRect menuRect = {x,y,160,240};
    
    [[PopMenuManager sharedInstance] showPopMenuSelecteWithFrame:menuRect
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
