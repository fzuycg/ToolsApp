//
//  YCGAlertView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/26.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "YCGAlertView.h"
#import "UIView+Parameter.h"

@interface YCGAlertView()

@property (nonatomic, strong) UIView *contentView;

//@property (nonatomic, copy) UIButton *sureButton;

@end

@implementation YCGAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancel sureButtonTitle:(NSString *)sure {
    self = [super init];
    if (self) {
        [self createUIWithTitle:title message:message cancelButtonTitle:cancel sureButtonTitle:sure];
    }
    return self;
}

- (void)createUIWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancel sureButtonTitle:(NSString *)sure {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    
    //------- 弹窗主内容 -------//
    self.contentView = [[UIView alloc]init];
    self.contentView.frame = CGRectMake(0, 0, kScreen_width - 80, 150);
    self.contentView.center = self.center;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 7;
    [self addSubview:self.contentView];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.contentView.sizeWidth, 22)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [self.contentView addSubview:titleLabel];
    
    // message
    UILabel *messageLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.contentView.sizeWidth, 22)];
    messageLable.font = [UIFont boldSystemFontOfSize:17];
    messageLable.textAlignment = NSTextAlignmentCenter;
    messageLable.text = message;
    [self.contentView addSubview:messageLable];
    
    
    // 取消按钮
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, self.contentView.sizeHeight - 40, self.contentView.sizeWidth/2, 40);
    cancelBtn.backgroundColor = [UIColor grayColor];
    [cancelBtn setTitle:cancel forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelBtn];
    
    // 确认按钮
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(cancelBtn.sizeWidth, cancelBtn.originY, cancelBtn.sizeWidth, 40);
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:sure forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:sureBtn];
}

- (void)cancelBtnClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(alertViewDidClickButtonWithIndex:)]) {
        [self.delegate alertViewDidClickButtonWithIndex:AlertCancelButtonClick];
    }
    [self dismiss];
}

- (void)sureBtnClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(alertViewDidClickButtonWithIndex:)]) {
        [self.delegate alertViewDidClickButtonWithIndex:AlertSureBUttonClick];
    }
    [self dismiss];
}

- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}

@end
