//
//  StatusBarMessageView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "StatusBarMessageView.h"

@interface StatusBarMessageView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation StatusBarMessageView {
    CGFloat _statusBarCenterY;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        //UIWindow 有三个层级，分别是Normal ,StatusBar,Alert.输出他们三个层级的值，我们发现从左到右依次是0，1000，2000
        //设置window的显示层级高于UIWindowLevelStatusBar.
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        [self createLabel];
        //makeKeyAndVisible不会使window的引用计数+1,所以在使用的时候一定要将window设置成全部变量,如果是个局部变量window在执行完makeKeyAndVisible方法之后会被释放,不会显示出来.
        [self makeKeyAndVisible];
    }
    return self;
}

- (void)createLabel {
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    _statusBarCenterY = statusBarFrame.size.height/2;
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, -statusBarFrame.size.height, statusBarFrame.size.width, statusBarFrame.size.height)];
    _contentView.backgroundColor = [UIColor redColor];
    [self addSubview:_contentView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, statusBarFrame.size.height-20, statusBarFrame.size.width, 20)];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:13];
    _label.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_label];
    
}

- (void)showStatusWithMessage:(NSString *)text {
    _label.text = text;
    if (self.contentView.centerY == _statusBarCenterY) {
        //当DGCustomStatusBar已经显示出来了,再连续点击显示按钮,取消延时执行,不让window隐藏.
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideWindow:) object:nil];
    }
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:1.0f animations:^{
        self.contentView.centerY = _statusBarCenterY;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideWindow:) withObject:nil afterDelay:1.5f];
    }];
}

///???:存在一个问题：收起来之后没有被持有者释放掉，如果在同一个页面再谈起一个AlertView就会出问题
- (void)hideWindow:(id)object {
    [UIView animateWithDuration:1.0f animations:^{
        self.contentView.centerY = -_statusBarCenterY;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

#pragma mark - setter
- (void)setStatusColor:(UIColor *)statusColor {
    _statusColor  =statusColor;
    _contentView.backgroundColor = statusColor;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _label.textColor = textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    _label.textAlignment = textAlignment;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    _label.font = textFont;
}


@end
