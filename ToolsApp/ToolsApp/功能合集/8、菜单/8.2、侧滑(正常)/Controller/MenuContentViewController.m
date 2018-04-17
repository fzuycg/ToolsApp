//
//  MenuContentViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/16.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MenuContentViewController.h"
#import "MenuContentHeaderView.h"
#import "MenuContentCell.h"

static CGFloat headerH = 200.0;
static NSString *CellID = @"cellID";

@interface MenuContentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) MenuContentHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MenuContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[@"会员特权",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的文件"];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.nameLabel.text = _dataArray[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_dataArray[indexPath.row]]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - 懒加载
- (MenuContentHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MenuContentHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, headerH)];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headerH, self.view.frame.size.height, self.view.frame.size.height-headerH)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[MenuContentCell class] forCellReuseIdentifier:CellID];
    }
    return _tableView;
}

@end
