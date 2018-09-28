//
//  CountDownButton.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/27.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "CountDownButton.h"
#import <MSWeakTimer.h>

typedef void(^ButtonClickedBlock)(void);
typedef void(^CountDownStartBlock)(void);
typedef void(^CountDownUnderwayBlock)(NSInteger restCountDownNum);
typedef void(^CountDownCompletionBlock)(void);

@interface CountDownButton()
/** 控制倒计时的timer */
@property (nonatomic, strong) MSWeakTimer *timer;
/** 按钮点击事件的回调 */
@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;
/** 倒计时开始时的回调 */
@property (nonatomic, copy) CountDownStartBlock countDownStartBlock;
/** 倒计时进行中的回调（每秒一次） */
@property (nonatomic, copy) CountDownUnderwayBlock countDownUnderwayBlock;
/** 倒计时完成时的回调 */
@property (nonatomic, copy) CountDownCompletionBlock countDownCompletionBlock;
@end

@implementation CountDownButton{
    /** 倒计时开始值 */
    NSInteger _startCountDownNum;
    /** 剩余倒计时的值 */
    NSInteger _restCountDownNum;
}

/**
 构造方法
 
 @param duration 倒计时时间
 @param buttonClicked 按钮点击事件的回调
 @param countDownStart 倒计时开始时的回调
 @param countDownUnderway 倒计时进行中的回调（每秒一次）
 @param countDownCompletion 倒计时完成时的回调
 @return 倒计时button
 */
- (instancetype)initWithDuration:(NSInteger)duration
                   buttonClicked:(void(^)(void))buttonClicked
                  countDownStart:(void(^)(void))countDownStart
               countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
             countDownCompletion:(void(^)(void))countDownCompletion {
    if (self = [super init]) {
        _startCountDownNum = duration;
        self.buttonClickedBlock       = buttonClicked;
        self.countDownStartBlock      = countDownStart;
        self.countDownUnderwayBlock   = countDownUnderway;
        self.countDownCompletionBlock = countDownCompletion;
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/** 按钮点击 */
- (void)buttonClicked:(CountDownButton *)sender {
    sender.enabled = NO;
    self.buttonClickedBlock();
}

/** 开始倒计时 */
- (void)startCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _restCountDownNum = _startCountDownNum;
    !self.countDownStartBlock ?: self.countDownStartBlock(); // 调用倒计时开始的block
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshButton) userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue()];
}

/** 刷新按钮内容 */
- (void)refreshButton {
    _restCountDownNum --;
    self.countDownUnderwayBlock(_restCountDownNum); // 调用倒计时进行中的回调
    if (_restCountDownNum == 0) {
        [self.timer invalidate];
        self.timer = nil;
        _restCountDownNum = _startCountDownNum;
        !self.countDownCompletionBlock ?: self.countDownCompletionBlock(); // 调用倒计时完成的回调
        self.enabled = YES;
    }
}

/** 结束倒计时 */
- (void)endCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.enabled = YES;
    !self.countDownCompletionBlock ?: self.countDownCompletionBlock();
}

- (void)dealloc {
    NSLog(@"倒计时按钮已释放");
}

@end
