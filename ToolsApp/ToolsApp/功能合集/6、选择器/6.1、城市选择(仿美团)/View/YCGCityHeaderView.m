//
//  YCGCityHeaderView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGCityHeaderView.h"
#import "YCGAreaMuneButton.h"
#import "NSString+Addition.h"

@interface YCGCityHeaderView() <UISearchBarDelegate>
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UILabel *currentCityLabel;
@property (nonatomic, weak) YCGAreaMuneButton *muneButton;

@end

@implementation YCGCityHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addLabel:frame];
        [self addButton:frame];
        [self addSearchBar:frame];
    }
    return self;
}

- (void)addSearchBar:(CGRect)frame {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 0, frame.size.width - 10, 40)];
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.placeholder = @"输入城市名称";
    [self addSubview:searchBar];
    self.searchBar = searchBar;
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 0.5)];
    separator.backgroundColor = YCGRGBAColor(155, 155, 155, 0.5);
    [self addSubview:separator];
}

- (void)addLabel:(CGRect)frame {
    UILabel *currentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString *str = @"当前选择:";
    CGFloat width = [str widthForContent:str withHeight:21 withFont:[UIFont systemFontOfSize:14]];
    currentLabel.frame = CGRectMake(10, frame.size.height-21-10, width, 21);
    currentLabel.text = str;
    currentLabel.textAlignment = NSTextAlignmentLeft;
    currentLabel.textColor = [UIColor blackColor];
    currentLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:currentLabel];
    
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentLabel.frame.origin.x+currentLabel.frame.size.width, frame.size.height-21-10, 200, 21)];
    cityLabel.textColor  = [UIColor blackColor];
    cityLabel.textAlignment = NSTextAlignmentLeft;
    cityLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:cityLabel];
    self.currentCityLabel = cityLabel;
    
}

- (void)addButton:(CGRect)frame {
    YCGAreaMuneButton *button = [[YCGAreaMuneButton alloc] initWithFrame:CGRectMake(frame.size.width - 95, frame.size.height - 31, 75, 21)];
    [button addTarget:self action:@selector(touchUpButtonEnevt:) forControlEvents:UIControlEventTouchUpInside];
    button.imageName = @"area_down_icon";
    button.title = @"选择区县";
    button.titleColor = YCGRGBAColor(155, 155, 155, 1.0);
    [self addSubview:button];
    self.muneButton = button;
}

- (void)touchUpButtonEnevt:(YCGAreaMuneButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.imageName = @"area_up_icon";
    }else {
        sender.imageName = @"area_down_icon";
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(cityNameWithSelected:)]) {
        [self.delegate cityNameWithSelected:sender.selected];
    }
}

#pragma mark - setter
- (void)setBtnTitle:(NSString *)btnTitle {
    _btnTitle = btnTitle;
    self.muneButton.title = btnTitle;
}

- (void)setCityName:(NSString *)cityName {
    _cityName = cityName;
    self.currentCityLabel.text = cityName;
}

#pragma mark - UISearchBarDelegate
// 开始编辑时
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(beginSearch)]) {
        [self.delegate beginSearch];
    }
}

// 编辑文本改变时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchText:)]) {
            [self.delegate searchText:searchText];
        }
    }
}

// 点击键盘上的搜索按钮时
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchText:)]) {
        [self.delegate searchText:searchBar.text];
    }
}

// 点击取消按钮时
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self cancelSearch];
}


//  取消搜索
- (void)cancelSearch {
    [_searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    _searchBar.text = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(endSearch)]) {
        [self.delegate endSearch];
    }
}


@end
