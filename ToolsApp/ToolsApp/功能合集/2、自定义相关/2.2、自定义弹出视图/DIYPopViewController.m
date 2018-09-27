//
//  DIYPopViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/28.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "DIYPopViewController.h"
#import "HubMessageView.h"
#import "StatusBarMessageView.h"
#import "YCGAlertView.h"

@interface DIYPopViewController ()<YCGAlertViewDelegate>
@property (nonatomic, strong) StatusBarMessageView *statusBar;
@property (nonatomic, strong) YCGAlertView *alertView;

@end

@implementation DIYPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoureArray =@[
                           @{@"title":@"简单屏幕提示",@"className":@""},
                           @{@"title":@"状态栏提示",@"className":@""},
                           @{@"title":@"自定义Alert",@"className":@""},
                           ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            [HubMessageView showMessage:@"这是一个普通的提示"];
            break;
        case 1:
            [self.statusBar showStatusWithMessage:@"网络异常"];
            break;
        case 2:
            
            [self.alertView show];
            break;
        default:
            break;
    }
}

#pragma mark - YCGAlertViewDelegate
- (void)alertViewDidClickButtonWithIndex:(NSInteger)index {
    if (index == 0) {
        NSLog(@"点击了取消按钮");
    }
    if (index == 1) {
        NSLog(@"点击了确定按钮");
    }
}

#pragma mark - Lazy
- (StatusBarMessageView *)statusBar {
    if (!_statusBar) {
        _statusBar = [[StatusBarMessageView alloc] init];
    }
    return _statusBar;
}

- (YCGAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[YCGAlertView alloc] initWithTitle:@"提示" message:@"你的应用有被入侵的风险！" cancelButtonTitle:@"取消" sureButtonTitle:@"确认"];
        _alertView.delegate = self;
    }
    return _alertView;
}


@end
