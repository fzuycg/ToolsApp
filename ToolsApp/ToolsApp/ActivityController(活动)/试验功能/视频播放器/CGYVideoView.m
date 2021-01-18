//
//  CGYVideoView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2019/1/8.
//  Copyright © 2019 com.yangcg.learn. All rights reserved.
//

#import "CGYVideoView.h"
#import <AVFoundation/AVFoundation.h>

@interface CGYVideoView ()
@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIButton *starButton;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *beginButton;
@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UILabel *beginLabel;
@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, strong) AVPlayerItem *playerItem;//
@property (nonatomic, assign) BOOL isPlaying;//

@end

@implementation CGYVideoView {
    BOOL _isShowToolbar;
    BOOL _isSliding;
    id _playTimeObserver;
}


#pragma mark - 构造方法
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //是否展示工具栏的开关
        _isShowToolbar = YES;

        //播放器的view
        UIView *playerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.playerView = playerView;
        [self addSubview:playerView];

        // 设置AVPlayer
        self.player = [[AVPlayer alloc] init];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.frame = self.bounds;

        /*
         AVLayerVideoGravityResize,       // 非均匀模式。两个维度完全填充至整个视图区域
         AVLayerVideoGravityResizeAspect,  // 等比例填充，直到一个维度到达区域边界
         AVLayerVideoGravityResizeAspectFill, // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
         */
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.playerView.layer addSublayer:_playerLayer];

        //在整个界面中间的一个开始按钮，如果暂停时候就出现
        UIButton *starButton = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-50)/2, (frame.size.height-50)/2, 50, 50)];
        self.starButton = starButton;
        starButton.center = self.playerView.center;
        [starButton setImage:[UIImage imageNamed:@"video-star"] forState:UIControlStateNormal];
        starButton.hidden = YES;
        [starButton addTarget:self action:@selector(clickStarButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.playerView addSubview:starButton];

        //工具栏的view
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
        self.bottomView = bottomView;
        bottomView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
        bottomView.hidden = !_isShowToolbar;
        [self.playerView addSubview:bottomView];

        //工具栏上的 开始/暂停 按钮
        UIButton *beginButton = [[UIButton alloc]initWithFrame:CGRectMake(10, (bottomView.frame.size.height-20)/2, 20, 20)];
        self.beginButton = beginButton;
        beginButton.backgroundColor = [UIColor redColor];
        [beginButton setImage:[UIImage imageNamed:@"video-begin-1"] forState:UIControlStateNormal];
        [beginButton setImage:[UIImage imageNamed:@"video-begin-2"] forState:UIControlStateSelected];
        [beginButton addTarget:self action:@selector(beginAction:) forControlEvents:UIControlEventTouchUpInside];
        beginButton.selected = YES;
        [self.bottomView addSubview:beginButton];

        //工具栏上的 音量/静音 按钮
        UIButton *voiceButton = [[UIButton alloc]initWithFrame:CGRectMake(bottomView.frame.size.width-10-14, (bottomView.frame.size.height-14)/2, 14, 14)];
        self.voiceButton = voiceButton;
        [voiceButton setImage:[UIImage imageNamed:@"video-voice-1"] forState:UIControlStateNormal];
        [voiceButton setImage:[UIImage imageNamed:@"video-voice-2"] forState:UIControlStateSelected];
        [voiceButton addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
        voiceButton.selected = YES;
        self.player.volume = 0;
        [self.bottomView addSubview:voiceButton];

        //当前时间的Label
        UILabel *beginLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(beginButton.frame)+10, beginButton.frame.origin.y, 30, 14)];
        self.beginLabel = beginLabel;
        beginLabel.font = [UIFont systemFontOfSize:14];
        beginLabel.textColor = [UIColor whiteColor];
        beginLabel.textAlignment = NSTextAlignmentCenter;
        beginLabel.adjustsFontSizeToFitWidth = YES;
        [self.bottomView addSubview:beginLabel];

        //总共时长的Label
        UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(voiceButton.frame.origin.x-10-30, voiceButton.frame.origin.y, 30, 14)];
        self.endLabel = endLabel;
        endLabel.font = [UIFont systemFontOfSize:14];
        endLabel.textColor = [UIColor whiteColor];
        endLabel.textAlignment = NSTextAlignmentCenter;
        endLabel.adjustsFontSizeToFitWidth = YES;
        [self.bottomView addSubview:endLabel];

        //进度条
        UISlider *playSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(beginLabel.frame), (bottomView.frame.size.height-2)/2, bottomView.frame.size.width-2*(CGRectGetMaxX(beginLabel.frame)), 2)];
        self.playSlider = playSlider;
        playSlider.value = 0;
        //左边的颜色
        playSlider.minimumTrackTintColor = [UIColor colorWithRed:246/255.0 green:89/255.0 blue:56/255.0 alpha:1];
        //        playSlider.maximumTrackTintColor = [UIColor lightGrayColor];
        //        playSlider.thumbTintColor = [UIColor whiteColor];
        //滑块的图片
        [playSlider setThumbImage:[UIImage imageNamed:@"video-slider"] forState:UIControlStateNormal];
        [self.bottomView addSubview:playSlider];

        //滑条的滑动-触摸到滑块
        [playSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        //滑条的滑动-抬起手指触摸结束
        [playSlider addTarget:self action:@selector(sliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        //滑条的滑动-滑块的位置改变
        [playSlider addTarget:self action:@selector(sliderTouchValueChanged:) forControlEvents:UIControlEventValueChanged];

        //显示到父视图的上层
        [self.playerView bringSubviewToFront:self.starButton];
        [self.playerView bringSubviewToFront:self.bottomView];
    }
    return self;
}

#pragma mark - 滑条的滑动事件 - 开始
-(void)sliderTouchDown:(UISlider *)slider{
    //暂停
    [self pause];
}

#pragma mark - 滑条的滑动事件 - 结束
-(void)sliderTouchUpInside:(UISlider *)slider{
    _isSliding = NO;
    //播放
    [self play];
}

#pragma mark - 滑条的滑动事件 - 改变
-(void)sliderTouchValueChanged:(UISlider *)slider{
    _isSliding = YES;
    [self pause];
    CMTime changedTime = CMTimeMakeWithSeconds(self.playSlider.value, 1.0);
    [_playerItem seekToTime:changedTime completionHandler:^(BOOL finished) {
        // 跳转完成后做某事
    }];
}

#pragma mark - 点击音量/静音按钮
-(void)voiceAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.player.volume = 0;
    }else{
        self.player.volume = 1.0;
    }
}

#pragma mark - 点击开始/暂停按钮
-(void)beginAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self play];
    }else{
        [self pause];
    }
}

#pragma mark - 点击中间的开始按钮
-(void)clickStarButton:(UIButton *)sender{
    [self play];
    self.beginButton.selected = YES;
}

#pragma mark - 加载视频地址
-(void)updatePlayerWithURL:(NSURL *)url{
    //如果有视频源的切换的话，要记得先移除再添加
    [self removeObserverAndNotificationWithPlayer];
    
    _playerItem = [AVPlayerItem playerItemWithURL:url]; // create item
    [_player  replaceCurrentItemWithPlayerItem:_playerItem]; // replaceCurrentItem
    [self addObserverAndNotification]; // 添加观察者，发布通知
}

#pragma mark - 添加观察者，发布通知
-(void)addObserverAndNotification{
    [_playerItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil]; // 观察status属性， 一共有三种属性
    [self monitoringPlayback:_playerItem]; // 监听播放

    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // 前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 后台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

#pragma mark - 播放完成的通知
- (void)playbackFinished:(NSNotification *)notification {
    _playerItem = [notification object];
    // 是否无限循环
    [_playerItem seekToTime:kCMTimeZero]; // 跳转到初始
    [_player play]; // 是否无限循环
    self.beginLabel.text = [self convertTime:0.0];
    self.playSlider.value = 0;
}

#pragma mark - 前台通知
-(void)enterForegroundNotification{
    [self play];
    self.beginButton.selected = self.isPlaying;
}

#pragma mark - 后台通知
-(void)enterBackgroundNotification{
    [self pause];
    self.beginButton.selected = self.isPlaying;
    _isShowToolbar = NO;
    self.bottomView.hidden = !_isShowToolbar;
}

#pragma mark - Status的KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        // 判断status 的 状态
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue]; // 获取更改后的状态
        if (status == AVPlayerStatusReadyToPlay) {
            NSLog(@"准备播放");
            // CMTime 本身是一个结构体
            CMTime duration = item.duration; // 获取视频长度
            NSLog(@"%.2f", CMTimeGetSeconds(duration));
            // 设置视频时间
            [self setMaxDuration:CMTimeGetSeconds(duration)];
            // 播放
            [self play];

        } else if (status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        } else {
            NSLog(@"AVPlayerStatusUnknown");
        }
    }
}

#pragma mark - 添加监听播放
- (void)monitoringPlayback:(AVPlayerItem *)item {
    __weak typeof(self)WeakSelf = self;

    // 播放进度, 每秒执行30次， CMTime 为30分之一秒
    _playTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        // 当前播放秒
        float currentPlayTime = (double)item.currentTime.value/ item.currentTime.timescale;
        // 更新slider, 如果正在滑动则不更新
        if (_isSliding == NO) {
            [WeakSelf updateVideoSlider:currentPlayTime];
        }
    }];
}

#pragma mark - 更新滑动条
- (void)updateVideoSlider:(float)currentTime {
    self.playSlider.value = currentTime;
    self.beginLabel.text = [self convertTime:currentTime];
}

#pragma mark - 设置最大时间
- (void)setMaxDuration:(CGFloat)duration {
    self.playSlider.maximumValue = duration;
    self.endLabel.text = [self convertTime:duration];
}

#pragma mark - 转换时间
-(NSString *)convertTime:(CGFloat)duration{
    // 相对格林时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:duration];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    if (duration / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }

    NSString *showTimeNew = [formatter stringFromDate:date];
    return showTimeNew;
}

#pragma mark - 播放
- (void)play {
    _isPlaying = YES;
    [_player play]; // 调用avplayer 的play方法
    self.starButton.hidden = YES;
}

#pragma mark - 暂停
- (void)pause {
    _isPlaying = NO;
    [_player pause];
    self.starButton.hidden = NO;
}

#pragma mark - 触屏-结束触摸
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isShowToolbar = !_isShowToolbar;
    self.bottomView.hidden = !_isShowToolbar;
}

#pragma mark - 移除通知和观察者
-(void)removeObserverAndNotificationWithPlayer{
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 销毁函数
-(void)dealloc{
    [self removeObserverAndNotificationWithPlayer];
    [_player removeTimeObserver:_playTimeObserver];
}

@end
