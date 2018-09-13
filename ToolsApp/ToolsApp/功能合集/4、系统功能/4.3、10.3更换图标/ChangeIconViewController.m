//
//  ChangeIconViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/9.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//
/**
 更换图标功能为iOS10.3之后提供的一个系统功能，主要方法：
 
 [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
 }];
 
 需要在 info.plist 里面填一些东西才能让它起作用，官方注释地址：https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/TP40009249-SW14
 
 */

#import "ChangeIconViewController.h"
#import "MarqueeLabelView.h"
#import <objc/message.h>

@interface ChangeIconViewController ()

@end

@implementation ChangeIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //判断是否支持更换图标
    if (@available(iOS 10.3, *)) {
        if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
            [self createMessageUI];
        }else{
            [self createBtnUI];
        }
    } else {
        [self createMessageUI];
    }
}

- (void)createMessageUI {
    MarqueeLabelView *view = [[MarqueeLabelView alloc] initWithFrame:CGRectMake(12,(kScreen_height-44)/2, kScreen_width-24, 44) withMessage:@"本系统不支持更换图标啊啊啊！！！"];
    [self.view addSubview:view];
}

- (void)createBtnUI {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-180)/2, kNavigation_HEIGHT+60, 180, 44)];
    btn1.layer.cornerRadius = 8;
    [btn1 setTitle:@"换成AppStore图标" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor orangeColor]];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-180)/2, kNavigation_HEIGHT+150, 180, 44)];
    btn2.layer.cornerRadius = 8;
    [btn2 setTitle:@"换成Safari图标" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor orangeColor]];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-180)/2, kNavigation_HEIGHT+240, 180, 44)];
    btn3.layer.cornerRadius = 8;
    [btn3 setTitle:@"恢复原来图标" forState:UIControlStateNormal];
    [btn3 setBackgroundColor:[UIColor orangeColor]];
    [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(10, kScreen_height-54, kScreen_width-20, 44)];
    btn4.layer.cornerRadius = 8;
    [btn4 setTitle:@"取消弹框确认" forState:UIControlStateNormal];
    [btn4 setBackgroundColor:[UIColor redColor]];
    [btn4 addTarget:self action:@selector(runtimeReplaceAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)btn1Click {
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:@"Appicon_AppStore" completionHandler:^(NSError * _Nullable error) {
            if (error) {
                DeLog(@"更换图标失败！");
            }
        }];
    }
}

- (void)btn2Click {
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:@"Appicon_Safari" completionHandler:^(NSError * _Nullable error) {
            if (error) {
                DeLog(@"更换图标失败！");
            }
        }];
    }
}

- (void)btn3Click {
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
            if (error) {
                DeLog(@"更换图标失败！");
            }
        }];
    }
}

// 利用runtime来替换展现弹出框的方法
- (void)runtimeReplaceAlert
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(ox_presentViewController:animated:completion:));
        // 交换方法实现
        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
}

// 自己的替换展示弹出框的方法
- (void)ox_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
        NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);
        
        // 换图标时的提示框的title和message都是nil，由此可特殊处理
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) { // 是换图标的提示
            return;
        } else {// 其他提示还是正常处理
            [self ox_presentViewController:viewControllerToPresent animated:flag completion:completion];
            return;
        }
    }
    
    [self ox_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
