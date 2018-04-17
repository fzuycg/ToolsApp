//
//  BrushBoardView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/12.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "BrushBoardView.h"

#define kWIDTH_MIN 5
#define kWIDTH_MAX 12

@interface BrushBoardView ()

@property (nonatomic, strong) NSMutableArray *pointArray;       //点集合
@property (nonatomic, assign) CGFloat currentWidth;             //当前宽度
@property (nonatomic, strong) UIImage *defaultImage;            //初始图片
@property (nonatomic, strong) UIImage *lastImage;               //上次图片

@property (nonatomic, assign) BOOL debug;                       //设置调试

@property (nonatomic, assign) CGPoint minPoint;
@property (nonatomic, assign) CGPoint maxPoint;
@end

@implementation BrushBoardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


/**
 更新UI
 */
- (void)updateUI {
    
}

- (void)okButtonClick {
    
}

- (void)cleanBtnClick {
    
}

#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - 懒加载
- (NSMutableArray *)pointArray {
    if (!_pointArray) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}


@end
