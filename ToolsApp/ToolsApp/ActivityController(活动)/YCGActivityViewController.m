//
//  YCGActivityViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGActivityViewController.h"

@interface YCGActivityViewController ()

@end

@implementation YCGActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"试验场";
    
    self.dataSoureArray =@[
                           @{@"title":@"1、浏览器",@"className":@"WebBrowserViewController"},
                           @{@"title":@"2、日志保存",@"className":@"LogSaveViewController"},
                           @{@"title":@"3、Markdown",@"className":@"MarkdownViewController"},
                           ];
}


@end
