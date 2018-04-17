//
//  MenuContentCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/16.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MenuContentCell.h"

@implementation MenuContentCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, (self.frame.size.height-30)/2, 30, 30)];
    [self addSubview:imageView];
    self.iconImageView = imageView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(48, (self.frame.size.height-30)/2, self.frame.size.width-58, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.nameLabel = label;
}

@end
