//
//  WaterFallCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "WaterFallCell.h"
#import <UIImageView+WebCache.h>

@interface WaterFallCell()
@property (nonatomic, retain)UIImageView *imageView;

@end

@implementation WaterFallCell

-(instancetype)initWithFrame:(CGRect)frame {
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

-(void)setModel:(WaterFallDataModel *)model {
    _model = model;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
    
    //⚠️注意：这里写成self.contentView.bounds会出错，用 nib约束 则不用写
    _imageView.frame = self.bounds;
}



@end
