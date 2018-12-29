//
//  CodeTextView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/10/22.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "CodeTextView.h"

@interface CodeTextView ()

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGFloat itemMargin;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIControl *maskView;

@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;

@property (nonatomic, strong) NSMutableArray<LineView *> *lineViews;

/// 临时保存上次的输入
@property (nonatomic, copy) NSString *tempStr;

@end

@implementation CodeTextView

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin {
    self = [super init];
    if (self) {
        self.itemCount = count;
        self.itemMargin = margin;
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    
    self.labels = @[].mutableCopy;
    self.lineViews = @[].mutableCopy;
    
    //
    UITextField *textField = [[UITextField alloc] init];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [textField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:textField];
    self.textField = textField;
    
    //
    UIButton *maskView = [UIButton new];
    maskView.backgroundColor = [UIColor whiteColor];
    [maskView addTarget:self action:@selector(clickMaskView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:maskView];
    self.maskView = maskView;
    
    for (NSInteger i=0; i<self.itemCount; i++) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor purpleColor];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:40];
        [self addSubview:label];
        [self.labels addObject:label];
    }
    
    for (NSInteger i=0; i<self.itemCount; i++) {
        LineView *lineView = [LineView new];
        lineView.backgroundColor = [UIColor redColor];
        [self addSubview:lineView];
        [self.lineViews addObject:lineView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.labels.count != self.itemCount) return;
    
    CGFloat temp = self.bounds.size.width - (self.itemMargin * (self.itemCount - 1));
    CGFloat w = temp / self.itemCount;
    CGFloat x = 0;
    for (NSInteger i=0; i < self.itemCount; i++) {
        x = i * (w + self.itemMargin);
        
        UILabel *label = self.labels[i];
        label.frame = CGRectMake(x, 0, w, self.bounds.size.height);
        
        UIView *lineView = self.lineViews[i];
        lineView.frame = CGRectMake(x, self.bounds.size.height - 1, w, 1);
    }
    
    self.textField.frame = self.bounds;
    self.maskView.frame = self.bounds;
}

#pragma mark - 编辑改变
- (void)editingChanged:(UITextField *)textField {
    if (textField.text.length > self.itemCount) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, self.itemCount)];
    }
    
    for (int i=0; i<self.itemCount; i++) {
        UILabel *label = [self.labels objectAtIndex:i];
        UIView *lineView = [self.lineViews objectAtIndex:i];
        
        if (i < textField.text.length) {
            label.text = [textField.text substringWithRange:NSMakeRange(i, 1)];
            lineView.backgroundColor = [UIColor greenColor];
        }else{
            label.text = nil;
            lineView.backgroundColor = [UIColor redColor];
        }
    }
    
    // 动画
    if (self.tempStr.length < textField.text.length) {
        if (textField.text == nil || textField.text.length <= 0) {
            [self.lineViews.firstObject animation];
        }else if (textField.text.length >= self.itemCount) {
            [self.lineViews.lastObject animation];
            [self animation:self.labels.lastObject];
        }else{
            [self.lineViews[self.textField.text.length - 1] animation];
            UILabel *label = self.labels[self.textField.text.length - 1];
            [self animation:label];
        }
    }
    
    self.tempStr = textField.text;
    
    if (textField.text.length >= self.itemCount) {
        [self.textField resignFirstResponder];
    }
}

- (void)animation:(UILabel *)label {
    CABasicAnimation  *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.15;
    animation.repeatCount  = 1;
    animation.fromValue = @(0.1);
    animation.toValue = @(1);
    [label .layer addAnimation:animation forKey:@"zoom"];
}

- (void)clickMaskView {
    [self.textField becomeFirstResponder];
}

- (BOOL)endEditing:(BOOL)force {
    [self.textField endEditing:force];
    return [super endEditing:force];
}

- (NSString *)code {
    return self.textField.text;
}

@end


#pragma mark -
#pragma mark - ----------下划线---------------
@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    UIView *colorView = [UIView new];
    [self addSubview:colorView];
    self.colorView = colorView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.colorView.frame = self.bounds;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor whiteColor]];
    self.colorView.backgroundColor = backgroundColor;
}

- (void)animation {
    [self.colorView.layer removeAllAnimations];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transfrom.scale.x"];
    animation.duration = 0.18;
    animation.repeatCount = 1;
    animation.fromValue = @(1.0);
    animation.toValue = @(0.1);
    animation.autoreverses = YES;
    
    [self.colorView.layer addAnimation:animation forKey:@"zoom.scale.x"];
}

@end
