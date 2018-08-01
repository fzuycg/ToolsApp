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

static CGFloat imageViewWH = 28; //图片的宽高
static CGFloat titleH = 30; //标题文字的高
static CGFloat buttonWH = 30; //按钮的宽高

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(addButtonIsClick:functionId:)]) {
        [self.delegate addButtonIsClick:self functionId:self.model.functionId];
    }
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
    self.isSelectStatus = model.isSelectStatus;
}

- (void)setIsEditStatus:(BOOL)isEditStatus {
    _isEditStatus = isEditStatus;
    self.addButton.hidden = !isEditStatus;
}

- (void)setIsSelectStatus:(BOOL)isSelectStatus {
    _isSelectStatus = isSelectStatus;
    if (isSelectStatus) {
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"减号.png"] forState:UIControlStateNormal];
    }else{
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - Lazy
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-imageViewWH)/2, (self.frame.size.height-imageViewWH-titleH)/2, imageViewWH, imageViewWH)];
    }
    return _imageView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-titleH, self.frame.size.width, titleH)];
        _title.font = [UIFont systemFontOfSize:13];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-buttonWH, 0, buttonWH, buttonWH)];
        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
//        [_addButton setImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
        _addButton.hidden = YES;
    }
    return _addButton;
}

@end
