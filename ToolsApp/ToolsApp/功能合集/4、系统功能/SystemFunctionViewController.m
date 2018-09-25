//
//  SystemFunctionViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/29.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "SystemFunctionViewController.h"

@interface SystemFunctionViewController ()

@end

@implementation SystemFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoureArray =@[
                           @{@"title":@"获取手机信息",@"className":@"IPhoneInfoViewController"},
                           @{@"title":@"分享功能",@"className":@"ShareViewController"},
                           @{@"title":@"更换图标",@"className":@"ChangeIconViewController"},
                           @{@"title":@"自动获取短信验证码",@"className":@"AutoCaptchaViewController"},
                           @{@"title":@"获取截屏",@"className":@"ScreenshotViewController"},
                           ];
}

@end
