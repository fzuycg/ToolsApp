//
//  YCGAreaMuneButton.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGAreaMuneButton.h"

@interface YCGAreaMuneButton()
@property (nonatomic, weak) UILabel *myLabel;
@property (nonatomic, weak) UIImageView *myImageView;

@end

@implementation YCGAreaMuneButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self myLabel:frame];
        [self myImageView:frame];
    }
    return self;
}

- (void)myLabel:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 10, frame.size.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    self.myLabel = label;
}

- (void)myImageView:(CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-12, (frame.size.height-5)/2, 7, 5)];
    [self addSubview:imageView];
    self.myImageView = imageView;
}

#pragma mark - setter && getter
- (void)setTitle:(NSString *)title {
    _title = title;
    self.myLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.myLabel.textColor = titleColor;
}

- (void)setImageName:(NSString *)imageName {
    self.myImageView.image = [UIImage imageNamed:imageName];
}

@end
