//
//  NoEditStatusHeaderCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/31.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "NoEditStatusHeaderCell.h"

@interface NoEditStatusHeaderCell()
@property (nonatomic, strong) UIImageView *imageView;

@end

static CGFloat imageViewWH = 20; //图片的宽高

@implementation NoEditStatusHeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.imageView];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

#pragma mark - Lazy
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-imageViewWH)/2, (self.frame.size.height-imageViewWH)/2, imageViewWH, imageViewWH)];
    }
    return _imageView;
}

@end
