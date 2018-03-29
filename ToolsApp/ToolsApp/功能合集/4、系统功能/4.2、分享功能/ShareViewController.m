//
//  ShareViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/29.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "ShareViewController.h"
#import "IFMShareView.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSoureArray =@[
                           @{@"title":@"单行样式",@"className":@""},
                           @{@"title":@"双行样式",@"className":@""},
                           @{@"title":@"多行样式",@"className":@""},
                           @{@"title":@"九宫格样式",@"className":@""},
                           @{@"title":@"自定义头部标题",@"className":@""},
                           @{@"title":@"自定义按钮/分割线",@"className":@""},
                           ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
