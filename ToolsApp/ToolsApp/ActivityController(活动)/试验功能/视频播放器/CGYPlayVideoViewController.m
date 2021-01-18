//
//  CGYPlayVideoViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2019/1/8.
//  Copyright © 2019 com.yangcg.learn. All rights reserved.
//

#import "CGYPlayVideoViewController.h"
#import "CGYVideoView.h"
#import "CLPlayerView.h"

@interface CGYPlayVideoViewController ()
@property (nonatomic, strong) CGYVideoView *playView;
@property (nonatomic, weak) CLPlayerView *playerView;

@end

@implementation CGYPlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)createView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"presentViewController";
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 90, kScreen_width, 300)];
    _playerView = playerView;
    [self.view addSubview:_playerView];
    [_playerView updateWithConfig:^(CLPlayerViewConfig *config) {
        //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
        config.isLandscape = NO;
        //全屏是否隐藏状态栏，默认一直不隐藏
        config.fullStatusBarHiddenType = FullStatusBarHiddenFollowToolBar;
        //顶部工具条隐藏样式，默认不隐藏
        config.topToolBarHiddenType = TopToolBarHiddenNever;
        //全屏手势控制，默认Yes
        config.fullGestureControl = NO;
        //小屏手势控制，默认NO
        config.smallGestureControl = YES;
        
        config.autoRotate = NO;
    }];
    //视频地址
    NSString *urlString = @"https://mlscourse-cdn.fintech.com/400070/201710/20171020101240511.mp4";
    _playerView.url = [NSURL URLWithString:urlString];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调,小屏状态才会调用，全屏默认变为小屏
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
        [self backAction];
    }];
    //播放完成回调
    [_playerView endPlay:^{
        NSLog(@"播放完成");
    }];
    
    //开始播放
    [_playerView beginButton:^{
        _playerView.url = [NSURL URLWithString:urlString];
    }];
    
    
    //直接设置全屏
    [_playerView setFullPlay];
}

- (void)createUI {
    NSString *urlString = @"https://mlscourse-cdn.fintech.com/400070/201710/20171020101240511.mp4";
    
    CGYVideoView *playView = [[CGYVideoView alloc] initWithFrame:self.view.bounds];
    [playView updatePlayerWithURL:[NSURL URLWithString:urlString]];
    self.playView = playView;
    [self.view addSubview:self.playView];
}

- (void)backAction {
    [_playerView destroyPlayer];
    [self dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark - 设置转屏
// 是否支持自动转屏
//- (BOOL)shouldAutorotate {
//    return YES;
//}
//// 支持哪些屏幕方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    NSLog(@"屏幕宽度:%f", kScreen_width);
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
//// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationLandscapeRight;
//}


@end
