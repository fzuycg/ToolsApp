//
//  NoEditStatusNaviView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/9.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "NoEditStatusNaviView.h"

@interface NoEditStatusNaviView()
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation NoEditStatusNaviView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.backButton];
    //添加搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(self.backButton.frame.size.width+self.backButton.frame.origin.x+5, StatusBar_HEIGHT+(NavigationBar_HEIGHT-40)/2, self.frame.size.width-self.backButton.frame.size.width-self.backButton.frame.origin.x-10, 40)];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;//不显示背景
    searchBar.placeholder = @"搜索";
    [self addSubview:searchBar];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
}

- (void)backButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonIsClick)]) {
        [self.delegate backButtonIsClick];
    }
}

#pragma mark - Lazy
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(12, StatusBar_HEIGHT, 50, NavigationBar_HEIGHT)];
        [_backButton setTitle:@"首页" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
