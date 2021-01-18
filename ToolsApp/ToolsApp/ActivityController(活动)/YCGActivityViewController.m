//
//  YCGActivityViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/15.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGActivityViewController.h"
#import "CGYPlayVideoViewController.h"

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
                           @{@"title":@"4、普通加载大图",@"className":@"LoadBigImageVC"},
                           @{@"title":@"5、RunLoop加载大图",@"className":@"LoadBigImageUseRunLoopVC"},
                           @{@"title":@"6、视频播放器",@"className":@"CGYPlayVideoViewController"},
                           ];
    
    [self createUI];
}

- (void)createUI {
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [leftbutton addTarget:self action:@selector(gotoPlayerView) forControlEvents:UIControlEventTouchUpInside];
    //[leftbutton setBackgroundColor:[UIColor blackColor]];
    [leftbutton setTitle:@"视频播放" forState:UIControlStateNormal];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.rightBarButtonItem=rightitem;
}

- (void)gotoPlayerView {
    CGYPlayVideoViewController *vc = [[CGYPlayVideoViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
