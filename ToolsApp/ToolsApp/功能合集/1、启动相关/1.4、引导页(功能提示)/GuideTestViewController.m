//
//  GuideTestViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/29.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "GuideTestViewController.h"
#import "GuideTestManager.h"

@interface GuideTestViewController ()
@property (nonatomic, weak) UIImageView *firstImageView;
@property (nonatomic, weak) UIButton *secondButton;
@property (nonatomic, weak) UILabel *thirdLabel;

@end

@implementation GuideTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[GuideTestManager shareManager] showGuideViewWithTapViews:@[_firstImageView,_secondButton,_thirdLabel] withTips:@[@"点我😩",@"下一步😤",@"没有啦!🤒"]];
}

- (void)createUI {
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_width-80, Navigation_HEIGHT+40, 40, 40)];
    firstImageView.image = [UIImage imageNamed:@"smile"];
    [self.view addSubview:firstImageView];
    self.firstImageView = firstImageView;
    
    UIButton *secondButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_width/2-50, kScreen_height-300, 100, 40)];
    [secondButton setTitle:@"我是按钮" forState:UIControlStateNormal];
    [secondButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:secondButton];
    self.secondButton = secondButton;
    
    UILabel *thiedLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, Navigation_HEIGHT+100, 100, 34)];
    thiedLabel.text = @"我是文字";
    thiedLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thiedLabel];
    self.thirdLabel = thiedLabel;
}

@end
