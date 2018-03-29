//
//  DIYPopViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/28.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "DIYPopViewController.h"
#import "HubMessageView.h"

@interface DIYPopViewController ()

@end

@implementation DIYPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoureArray =@[
                           @{@"title":@"简单屏幕提示",@"className":@""},
                           @{@"title":@"状态栏提示",@"className":@""},
                           ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            [HubMessageView showMessage:@"这是一个普通的提示"];
            break;
        case 1:
            
            break;
        default:
            break;
    }
}



@end
