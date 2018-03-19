//
//  YCGBaseTableViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/16.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGBaseTableViewController.h"
#import "YCGHomeDataModel.h"

const int cellHeight = 60;

static NSString *homeCellIdentifier = @"homeCellIdentifier";

@interface YCGBaseTableViewController ()
@property (nonatomic, strong) NSArray<YCGHomeDataModel *> *modelArray;

@end

@implementation YCGBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //cell分割线向左移动15像素
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setDataSoureArray:(NSArray *)dataSoureArray {
    _modelArray = [YCGHomeDataModel mj_objectArrayWithKeyValuesArray:dataSoureArray];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:homeCellIdentifier];
    }
    
    YCGHomeDataModel *model =[_modelArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text =model.title;
    cell.detailTextLabel.text =model.className;
    cell.contentView.backgroundColor =YCGRandomColor;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YCGHomeDataModel *model =[_modelArray objectAtIndex:indexPath.row];
    
    UIViewController *vc =[[NSClassFromString(model.className) alloc] init];
    vc.title =model.title;
    if (vc) {
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    NSRange range;
    range = [model.className rangeOfString:@"Storyboard"];
    if (range.location != NSNotFound) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:model.className bundle:nil];
        
        UIViewController  *cardVC = [storyBoard instantiateViewControllerWithIdentifier:model.className];
        if (cardVC) {
            cardVC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:cardVC animated:YES];
            
        }
    }
    else{
    }
}


@end
