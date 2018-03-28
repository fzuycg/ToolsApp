//
//  CardLayoutCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CardLayoutCell.h"
#import <UIImageView+WebCache.h>

@interface CardLayoutCell()
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *tipLabel;
@end

@implementation CardLayoutCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.contentView.backgroundColor = [UIColor yellowColor];
    self.contentView.layer.cornerRadius = 15;
    self.contentView.clipsToBounds = YES;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height/3*2)];
    [self.contentView addSubview:_imageView];
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.contentView.frame.size.height/3-30)/2+_imageView.frame.size.height, self.contentView.frame.size.width, 30)];
    _tipLabel.font = [UIFont systemFontOfSize:17];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_tipLabel];
}

- (void)setModel:(CycleImageModel *)model {
    _model = model;
    if ([model.imageUrl isValidUrl]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        _imageView.image = [UIImage imageNamed:model.imageUrl];
    }
    
    _imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height/3*2);
    
    _tipLabel.text = model.imageTip;
}

@end
