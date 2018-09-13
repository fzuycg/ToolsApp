//
//  IsEditStatusNaviView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/9.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "IsEditStatusNaviView.h"

@interface IsEditStatusNaviView ()
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *completeButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation IsEditStatusNaviView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.cancelButton];
    [self addSubview:self.completeButton];
    [self addSubview:self.titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
}

- (void)cancelButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonIsClick)]) {
        [self.delegate cancelButtonIsClick];
    }
}

- (void)completeButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(completeButtonIsClick)]) {
        [self.delegate completeButtonIsClick];
    }
}

#pragma mark - Lazy
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(12, kStatusBar_HEIGHT, 50, kNavigationBar_HEIGHT)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50-12, kStatusBar_HEIGHT, 50, kNavigationBar_HEIGHT)];
        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(completeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, kStatusBar_HEIGHT, (self.frame.size.width-124), kNavigationBar_HEIGHT)];
        _titleLabel.text = @"我的应用编辑";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
