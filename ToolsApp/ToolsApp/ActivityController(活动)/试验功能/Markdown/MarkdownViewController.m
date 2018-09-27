//
//  MarkdownViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/10.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MarkdownViewController.h"


@interface MarkdownViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation MarkdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, kNavigation_HEIGHT+40, kScreen_width-80, 40)];
    button.backgroundColor = [UIColor brownColor];
    [button setTitle:@"防止暴力点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 7;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.button = button;
}

//方法一：通过系统控件的方法响应顺序实现
- (void)buttonClick:(UIButton *)button {
    //多久时间 间隔后才允许再次响应按钮事件
    static NSTimeInterval  delayTime = 0.25f;
    //点击按钮后,先取消之前的操作，再进行需要进行的操作
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonClicked:) object:button];
    [self performSelector:@selector(buttonClicked:)withObject:button afterDelay:delayTime];
}

//方法二：计时器控制实现
-(void)buttonClicked:(id)sender{
    self.button.enabled =NO;
    //多久时间 间隔后才允许再次响应按钮事件
    static NSTimeInterval  delayTime = 0.25f;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:delayTime];//防止重复点击
}

-(void)changeButtonStatus{
    self.button.enabled =YES;
    NSLog(@"点击了按钮");
}

@end
