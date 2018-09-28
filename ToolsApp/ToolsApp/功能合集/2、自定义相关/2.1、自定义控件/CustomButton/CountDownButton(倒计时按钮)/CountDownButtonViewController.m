//
//  CountDownButtonViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/27.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "CountDownButtonViewController.h"
#import "CountDownButton.h"
#import "HubMessageView.h"

@interface CountDownButtonViewController ()
@property (nonatomic, strong) CountDownButton *button;
@end

@implementation CountDownButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, kNavigation_HEIGHT+20, kScreen_width-50-120, 34)];
    textField.placeholder = @"输入验证码";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    __weak __typeof__(self) weakSelf = self;
    
    self.button = [[CountDownButton alloc] initWithDuration:10 buttonClicked:^{
        //------- 按钮点击 -------//
        [HubMessageView showMessage:@"正在获取验证码..."];
        // 请求数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            int a = arc4random() % 2;
            if (a == 0) {
                // 获取成功
                [HubMessageView showMessage:@"验证码已发送"];
                // 获取到验证码后开始倒计时
                [weakSelf.button startCountDown];
            } else {
                // 获取失败
                [HubMessageView showMessage:@"获取失败，请重试"];
                weakSelf.button.enabled = YES;
            }
        });
    } countDownStart:^{
        //------- 倒计时开始 -------//
        NSLog(@"倒计时开始");
    } countDownUnderway:^(NSInteger restCountDownNum) {
        //------- 倒计时进行中 -------//
        [weakSelf.button setTitle:[NSString stringWithFormat:@"再次获取(%ld秒)", restCountDownNum] forState:UIControlStateNormal];
    } countDownCompletion:^{
        //------- 倒计时结束 -------//
        [weakSelf.button setTitle:@"获取验证码" forState:UIControlStateNormal];
        NSLog(@"倒计时结束");
    }];
    
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(kScreen_width-20-120, kNavigation_HEIGHT+20, 120, 34);
    [self.button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}

@end
