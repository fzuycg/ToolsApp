//
//  CollectionReusableHeaderView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CollectionReusableHeaderView.h"

@interface CollectionReusableHeaderView()
@property (nonatomic, strong) UILabel *sectionTitle;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation CollectionReusableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.sectionTitle];
    [self addSubview:self.lineView];
}

- (void)setSectionTitleText:(NSString *)sectionTitleText {
    _sectionTitleText = sectionTitleText;
    self.sectionTitle.text = sectionTitleText;
}

- (void)setIsFirstSection:(BOOL)isFirstSection {
    _isFirstSection = isFirstSection;
    self.lineView.hidden = !isFirstSection;
}

#pragma mark - Lazy
- (UILabel *)sectionTitle {
    if (!_sectionTitle) {
        _sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, self.frame.size.width-32, self.frame.size.height)];
        _sectionTitle.textAlignment = NSTextAlignmentLeft;
        _sectionTitle.font = [UIFont systemFontOfSize:18];
    }
    return _sectionTitle;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

@end
