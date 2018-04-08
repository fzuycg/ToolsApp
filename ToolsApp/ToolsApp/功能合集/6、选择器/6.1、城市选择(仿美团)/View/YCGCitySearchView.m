//
//  YCGCitySearchView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGCitySearchView.h"

static NSString *SearchCell = @"SearchCell";

@interface YCGCitySearchView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YCGCitySearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - setter && getter
- (void)setResultArray:(NSMutableArray *)resultArray {
    _resultArray = resultArray;
    [self addSubview:_tableView];
    [_tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableView class] forCellReuseIdentifier:SearchCell];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCell forIndexPath:indexPath];
    NSDictionary *dic = _resultArray[indexPath.row];
    NSString *city = [NSString stringWithFormat:@"%@, %@", [dic valueForKey:@"city"], [dic valueForKey:@"super"]];
    cell.textLabel.text = city;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _resultArray[indexPath.row];
    if (![[dic valueForKey:@"city"] isEqualToString:@"抱歉"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchResults:)]) {
            [self.delegate searchResults:dic];
        }
    }
}

#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchViewToExit)]) {
        [self.delegate touchViewToExit];
    }
}


@end
