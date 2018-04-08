//
//  YCGCityCollectionViewCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGCityCollectionViewCell.h"

@interface YCGCityCollectionViewCell()
@property (nonatomic, strong) UILabel *label;

@end

@implementation YCGCityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLabel];
    }
    return self;
}

- (void)setupLabel{
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont systemFontOfSize:14.0]];
    [self addSubview:label];
    self.label = label;
}

// 设置 cell 的 border
- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = YCGRGBAColor(155, 155, 165, 0.5).CGColor;
    self.layer.masksToBounds = YES;
}

#pragma mark - setter
- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

@end
