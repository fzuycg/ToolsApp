//
//  AutoCaptchaViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "AutoCaptchaViewController.h"

@interface AutoCaptchaViewController ()
@property (nonatomic, strong) UITextField *textField;

@end

@implementation AutoCaptchaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, kNavigation_HEIGHT+20, kScreen_width-40, 40)];
    
    if (@available(iOS 12.0, *)) {
        textField.textContentType = UITextContentTypeOneTimeCode;
    }
    textField.placeholder = @"短信验证码";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [textField becomeFirstResponder];
    [self.view addSubview:textField];
    self.textField = textField;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
