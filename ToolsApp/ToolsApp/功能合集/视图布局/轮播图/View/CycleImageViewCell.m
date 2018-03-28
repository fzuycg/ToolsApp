//
//  CycleImageViewCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CycleImageViewCell.h"
#import <UIImageView+WebCache.h>

@interface CycleImageViewCell ()
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation CycleImageViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_imageView];
}

- (void)setModel:(CycleImageModel *)model {
    _model = model;
    if ([model.imageUrl isValidUrl]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"image0.jpg"]];
    }else{
        _imageView.image = [UIImage imageNamed:model.imageUrl];
    }
    
    _imageView.frame = self.bounds;
}

@end
