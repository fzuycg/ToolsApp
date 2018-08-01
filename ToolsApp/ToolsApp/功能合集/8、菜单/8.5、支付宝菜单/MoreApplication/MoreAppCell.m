//
//  MoreAppCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MoreAppCell.h"
#import "BoxFunctionModel.h"

@interface MoreAppCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation MoreAppCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI  ];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.imageView];
    [self addSubview:self.title];
    [self addSubview:self.addButton];
}

- (void)addButtonClick {
    
}

#pragma mark - setter
- (void)setModel:(BoxFunctionModel *)model {
    _model = model;
    self.title.text = model.title;
    if (model.image) {
        self.imageView.image = model.image;
    }else{
        self.imageView.image = [UIImage imageNamed:@"占位图.png"];
    }
}

- (void)setIsEditStatus:(BOOL)isEditStatus {
    _isEditStatus = isEditStatus;
    self.addButton.hidden = !isEditStatus;
}

- (void)setIsSelectStatus:(BOOL)isSelectStatus {
    _isSelectStatus = isSelectStatus;
    if (isSelectStatus) {
        [self.addButton setImage:[UIImage imageNamed:@"减号.png"] forState:UIControlStateNormal];
    }else{
        [self.addButton setImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - Lazy
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, self.frame.size.width-40, self.frame.size.height-30-10)];
    }
    return _imageView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
        _title.font = [UIFont systemFontOfSize:13];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-25, 0, 25, 25)];
        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
        _addButton.hidden = YES;
    }
    return _addButton;
}

@end
