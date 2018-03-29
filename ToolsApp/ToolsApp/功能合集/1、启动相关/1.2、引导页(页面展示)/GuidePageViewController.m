//
//  GuidePageViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/19.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "GuidePageViewController.h"
#import "YCGGuidePageView.h"

@interface GuidePageViewController ()

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self addGuidePageView];
}

- (void)addGuidePageView {
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    YCGGuidePageView *guidePageView = [[YCGGuidePageView alloc] initGuideViewWithImages:@[@"guide_01.jpg",@"guide_02.jpg",@"guide_03.jpg",@"guide_04.jpg"]];
    guidePageView.isShowPageView = YES;
    guidePageView.isScrollOut = NO;
    guidePageView.currentColor = [UIColor redColor];
    [window addSubview:guidePageView];
}

- (void)createUI {
    
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"home_bgImage.jpg"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(130, 100, 200, 30)];
    [label setFont:[UIFont systemFontOfSize:24]];
    [label setText:@"哇!首页出来了"];
    [imageView addSubview:label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_width-100, kScreen_height-50, 80, 30)];
    [button setTitle:@"再看一遍" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onceAgain) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    imageView.userInteractionEnabled =YES;
    
}

- (void)onceAgain {
    [self addGuidePageView];
}


@end
