//
//  LaunchViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/29.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoureArray =@[
                           @{@"title":@"开屏广告",@"className":@"LaunchAdViewController"},
                           @{@"title":@"引导页(页面展示)",@"className":@"GuidePageViewController"},
                           @{@"title":@"启动通知",@"className":@"LaunchNoticeViewController"},
                           @{@"title":@"引导页(功能提示)",@"className":@"GuideTestViewController"},
                           ];
}
@end
