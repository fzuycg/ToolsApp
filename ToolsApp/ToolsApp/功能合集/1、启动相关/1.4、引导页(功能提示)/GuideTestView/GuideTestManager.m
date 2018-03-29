//
//  GuideTestManager.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/29.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "GuideTestManager.h"

//圆圈的半径
const float radius =40;

@interface GuideTestManager()
@property (nonatomic,strong) UIView *bgView;                        //背景
@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;    //手势
@property (nonatomic,assign) NSInteger tapNumber;                   //点击次数
@property (nonatomic,strong) NSArray *tapViews;                     //点击的 view 数组
@property (nonatomic,strong) NSArray *tips;                         //需要显示的文字数组
@end

@implementation GuideTestManager

+ (instancetype)shareManager {
    static GuideTestManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        instance = [[GuideTestManager alloc] init];
    });
    return instance;
}

- (void)showGuideViewWithTapViews:(NSArray<UIView *>*)tapViews withTips:(NSArray<NSString *>*)tips {
    _tapViews =tapViews;
    _tips = tips;
    _tapNumber =0;
    //背景蒙层
    CGRect screenframe =[UIScreen mainScreen].bounds;
    UIView *bgView =[[UIView alloc]initWithFrame:screenframe];
    bgView.backgroundColor =JDCOLOR_FROM_RGB_OxFF_ALPHA(0x323232, 0.7);
    self.bgView =bgView;
    //添加手势
    self.tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureTapClick:)];
    [self.bgView addGestureRecognizer:_tapGesture];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    
    [self addBezierPathWithFrame:screenframe tapView:self.tapViews[self.tapNumber] tip:self.tips[self.tapNumber]];
    
}

- (void)addBezierPathWithFrame:(CGRect)screenframe tapView:(UIView *)view tip:(NSString *)tip
{
    CGRect tap_frame =[[view superview] convertRect:view.frame toView:self.bgView];
    
    //通过 UIBezierPath 创建路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:screenframe];
    
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(tap_frame.origin.x + tap_frame.size.width/2.0, tap_frame.origin.y + tap_frame.size.height/2.0) radius:radius startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    
    //利用CAShapeLayer 的 path 属性
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [self.bgView.layer setMask:shapeLayer];
    
    
    CGFloat x = CGRectGetMidX(tap_frame);
    CGFloat y = CGRectGetMaxY(tap_frame) + radius;
    for (UIView *view in self.bgView.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] || [view isKindOfClass:[UILabel class]])
            [view removeFromSuperview];
    }
    
    UIImage *guideImage = [UIImage imageNamed:@"guideTest"];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x-30,y,guideImage.size.width,guideImage.size.height)];
    imageView.image = guideImage;
    [self.bgView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setFont:[UIFont systemFontOfSize:14.0]];
    label.text = tip;
    label.textColor = [UIColor whiteColor];
    //使用代码布局 需要将这个属性设置为NO
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bgView addSubview:label];
    
    NSLayoutConstraint * constraintx = nil;
    //将屏幕分成三等分 来确定文字是靠左还是居中 还是靠右 (大概 可以自己调整)
    if (x <= screenframe.size.width / 3.0) {
        //创建x居左的约束
        constraintx = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    }
    else if ((x > screenframe.size.width / 3.0) &&(x <= screenframe.size.width * 2 / 3.0))
    {
        //创建x居中的约束
        constraintx = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    }
    else
    {
        //创建x居右的约束
        constraintx = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    }
    //创建y坐标的约束
    NSLayoutConstraint * constrainty = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    
    [self.bgView addConstraints:@[constraintx,constrainty]];
    
    _tapNumber ++;
}

#pragma mark == event response
- (void)sureTapClick:(UITapGestureRecognizer *)tap
{
    if (_tapNumber == self.tapViews.count) {
        [_bgView removeFromSuperview];
    }
    else
    {
        CGRect frame = [UIScreen mainScreen].bounds;
        [self addBezierPathWithFrame:frame tapView:self.tapViews[self.tapNumber] tip:self.tips[self.tapNumber]];
        
    }
}

@end
