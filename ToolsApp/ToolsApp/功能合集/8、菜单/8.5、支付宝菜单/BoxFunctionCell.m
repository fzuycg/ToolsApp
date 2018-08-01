//
//  BoxFunctionCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/26.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "BoxFunctionCell.h"
#import "BoxFunctionModel.h"

@interface BoxFunctionCell ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BoxFunctionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.imageView];
}

- (void)setModel:(BoxFunctionModel *)model {
    _model = model;
    self.label.text = model.title;
    if (model.image) {
        self.imageView.image = model.image;
    }else{
        self.imageView.image = [UIImage imageNamed:@"占位图.png"];
    }
}

#pragma mark - lazy
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-30, self.contentView.frame.size.width, 30)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:13];
    }
    return _label;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, self.contentView.frame.size.width-40, self.contentView.frame.size.height-30)];
    }
    return _imageView;
}

@end
