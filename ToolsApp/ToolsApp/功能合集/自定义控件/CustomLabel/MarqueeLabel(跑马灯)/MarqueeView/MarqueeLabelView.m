//
//  MarqueeLabelView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/22.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MarqueeLabelView.h"

//每秒钟走几个字
const int num = 3;

@interface MarqueeLabelView()
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) CGFloat textWidth;
@property (nonatomic, retain) UILabel *firstLabel;
@property (nonatomic, retain) UILabel *secondLabel;

@end

@implementation MarqueeLabelView

- (instancetype)initWithFrame:(CGRect)frame withMessage:(NSString *)message {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _message = [NSString stringWithFormat:@"  %@  ",message];
        self.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _firstLabel.font = [UIFont systemFontOfSize:14];
    _firstLabel.text = _message;
    _firstLabel.textAlignment = NSTextAlignmentLeft;
    [_firstLabel sizeToFit];
    _firstLabel.centerY = self.sizeHeight/2;
    [self addSubview:_firstLabel];
    
    _textWidth = _firstLabel.sizeWidth;
    
    if (_textWidth>self.sizeWidth) {
        _secondLabel = [[UILabel alloc] initWithFrame:_firstLabel.frame];
        _secondLabel.font = [UIFont systemFontOfSize:14];
        _secondLabel.text = _message;
        _secondLabel.textAlignment = NSTextAlignmentLeft;
        _secondLabel.originX = CGRectGetMaxX(_firstLabel.frame);
        [_secondLabel sizeToFit];
        [self addSubview:_secondLabel];
        
        [self startAnimation];
    }
    
    
}

- (void)startAnimation
{
    //计算走完一次需要的时间
    NSInteger time = _message.length / num;
    
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionRepeat animations:^{
        
        _firstLabel.originX = -_textWidth;
        _secondLabel.originX = 0;
        
    } completion:nil];
}


@end
