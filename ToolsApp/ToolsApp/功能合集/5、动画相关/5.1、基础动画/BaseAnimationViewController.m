//
//  BaseAnimationViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/9.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "BaseAnimationViewController.h"

@interface BaseAnimationViewController ()

@end

@implementation BaseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAnimation_X];
    [self addAnimation_Y];
    [self addAnimation_Z];
}

#pragma mark - 翻转
/**
 以 X轴 为旋转轴
 */
- (void)addAnimation_X {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 70, 70)];
    imageView.image = [UIImage imageNamed:@"Apple"];
    [self.view addSubview:imageView];
    //设置layer坐标系的中心点默认是(0.5,0.5)
    //rorationImageViewX.layer.anchorPoint =CGPointMake(0, 0.5);
    CABasicAnimation *rorationAnimX =[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rorationAnimX.beginTime =0;
    rorationAnimX.toValue = @(2*M_PI);
    rorationAnimX.duration =1.5;
    rorationAnimX.removedOnCompletion = NO;
    rorationAnimX.repeatCount = INFINITY;
    [imageView.layer addAnimation:rorationAnimX forKey:@"rotationAnimX"];
}

/**
 以 Y轴 为旋转轴
 */
- (void)addAnimation_Y {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 100, 70, 70)];
    imageView.image = [UIImage imageNamed:@"Apple"];
    [self.view addSubview:imageView];
    CABasicAnimation *rorationAnimY =[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rorationAnimY.beginTime =0;
    rorationAnimY.toValue = @(2*M_PI);
    rorationAnimY.duration =1.5;
    rorationAnimY.removedOnCompletion = NO;
    rorationAnimY.repeatCount = INFINITY;
    [imageView.layer addAnimation:rorationAnimY forKey:@"rotationAnimY"];
}

/**
 以 Z轴 为旋转轴
 */
- (void)addAnimation_Z {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 100, 70, 70)];
    imageView.image = [UIImage imageNamed:@"Apple"];
    [self.view addSubview:imageView];
    CABasicAnimation *rorationAnimZ =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rorationAnimZ.beginTime =0;
    rorationAnimZ.toValue = @(2*M_PI);
    rorationAnimZ.duration =1.5;
    rorationAnimZ.removedOnCompletion = NO;
    rorationAnimZ.repeatCount = INFINITY;
    [imageView.layer addAnimation:rorationAnimZ forKey:@"rotationAnimZ"];
}

#pragma mark - 移动
- (void)addAnimation_move {
    
}

#pragma mark -

@end
