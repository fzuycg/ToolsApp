//
//  MyButton.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/10/24.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

// 重写 initWithFrame: 方法；如果项目中使用到的按钮是通过xib生成的，则此处重写 awakeFromNib: 方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) { // 给按钮添加通知监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unHighlight) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc {  // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL inside = [super pointInside:point withEvent:event];
    if (inside && !self.isHighlighted && event.type == UIEventTypeTouches){
        self.highlighted = YES;
    }
    return inside;
}

- (void)unHighlight {
    self.highlighted = false;
}

//- (void)setHighlighted:(BOOL)highlighted
//{
//    
//}

@end
