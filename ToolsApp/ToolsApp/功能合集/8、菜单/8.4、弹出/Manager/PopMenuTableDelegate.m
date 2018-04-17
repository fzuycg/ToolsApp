//
//  PopMenuTableDelegate.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "PopMenuTableDelegate.h"

@interface PopMenuTableDelegate()
@property (nonatomic, copy) TableViewDidSelectRowAtIndexPath tableViewDidSelectRowAtIndexPath;
@end

@implementation PopMenuTableDelegate

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


- (instancetype)initWithDidSelectRowAtIndexPath:(TableViewDidSelectRowAtIndexPath)tableViewDidSelectRowAtIndexPath {
    if (self = [super init]) {
        self.tableViewDidSelectRowAtIndexPath = [tableViewDidSelectRowAtIndexPath copy];
    }
    return self;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.tableViewDidSelectRowAtIndexPath) {
        self.tableViewDidSelectRowAtIndexPath(indexPath.row);
    }
}
@end
