//
//  MenuContentHeaderView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/16.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MenuContentHeaderView.h"

@interface MenuContentHeaderView()

@end

@implementation MenuContentHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor redColor];
}

@end
