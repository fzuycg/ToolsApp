//
//  SuspensionButton.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "SuspensionButton.h"

@interface SuspensionButton ()
@property (nonatomic, assign) CGFloat btndge;   //按钮边距
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *button;

@end

@implementation SuspensionButton {
    CGFloat _buttonRadius;  //按钮半径
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];//创建手势
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:pan];
        
        _buttonRadius = frame.size.width/2;
        self.layer.cornerRadius = _buttonRadius;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.title];
    [self addSubview:self.imageView];
    [self addSubview:self.button];
}

- (void)buttonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(suspensionButtonClick)]) {
        [self.delegate suspensionButtonClick];
    }
}

#pragma mark - 设置参数
- (void)setButtonEdge:(CGFloat)buttonEdge {
    _btndge = buttonEdge;
}

- (void)setButtonImage:(UIImage *)image {
    if (image) {
        self.imageView.hidden = NO;
        self.imageView.image = image;
    }
}

- (void)setButtonTitle:(NSString *)text {
    if (text.length > 0) {
        self.title.hidden = NO;
        self.title.text = text;
    }
}

- (void)setButtonTitleColor:(UIColor *)color {
    if (color && self.title.hidden == NO) {
        self.title.textColor = color;
    }
}

- (void)setButtonBackgroundColor:(UIColor *)color {
    if (color) {
        self.backgroundColor = color;
    }
}

#pragma mark - 手势
- (void)handlePan:(UIPanGestureRecognizer *)rec {
    
    CGPoint point = [rec translationInView:[UIApplication sharedApplication].keyWindow];
    
//    NSLog(@"%f,%f",point.x,point.y);
    
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    
    [rec setTranslation:CGPointZero inView:[UIApplication sharedApplication].keyWindow];
    
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (self.frame.origin.x < kScreen_width/2) {
            [self viewMove:rec.view point:CGPointMake((_buttonRadius+self.btndge), rec.view.center.y + point.y)];
            if (self.frame.origin.y < kNavigation_HEIGHT ) {
                [self viewMove:rec.view point:CGPointMake((_buttonRadius+self.btndge), kNavigation_HEIGHT + (_buttonRadius+self.btndge))];
            }
            if (self.frame.origin.y > kScreen_height - kTabBar_height) {
                [self viewMove:rec.view point:CGPointMake((_buttonRadius+self.btndge), kScreen_height - kTabBar_height - (_buttonRadius+self.btndge))];
            }
        }else {
            [self viewMove:rec.view point:CGPointMake(kScreen_width - (_buttonRadius+self.btndge), rec.view.center.y + point.y)];
            if (self.frame.origin.y < kNavigation_HEIGHT ) {
                [self viewMove:rec.view point:CGPointMake(kScreen_width - (_buttonRadius+self.btndge), kNavigation_HEIGHT + (_buttonRadius+self.btndge))];
            }
            if (self.frame.origin.y > kScreen_height - kTabBar_height) {
                [self viewMove:rec.view point:CGPointMake(kScreen_width - (_buttonRadius+self.btndge), kScreen_height - kTabBar_height - (_buttonRadius+self.btndge))];
            }
        }
    }
}

- (void)viewMove:(UIView *)view point:(CGPoint)point {
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.center = point;
                     }
                     completion:nil];
}

#pragma mark - Lazy
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = NO;
        _imageView.hidden = YES;
    }
    return _imageView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:self.bounds];
        _title.userInteractionEnabled = NO;
        _title.font = [UIFont systemFontOfSize:13];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.hidden = YES;
    }
    return _title;
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:self.bounds];
        _button.backgroundColor = [UIColor clearColor];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


@end
