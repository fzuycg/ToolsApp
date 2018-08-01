//
//  ALiPayHomeViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/26.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "ALiPayHomeViewController.h"
#import "BoxViewI700.h"
#import "BoxFunctionModel.h"
#import "MoreAppViewController.h"
#import "UIView+Parameter.h"

@interface ALiPayHomeViewController () <BoxViewI700Delegate>
@property (nonatomic, strong) BoxViewI700 *appView;

@end

@implementation ALiPayHomeViewController {
    CGFloat _boxViewH; //控件高度
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"支付宝";
    
    [self readData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createUI];
    [self refreshUI];
}

- (void)readData {
    //JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BoxFunction" ofType:@"json"];
    
    //加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //将JSON数据转为NSArray或NSDictionary
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dict in dictArray) {
        BoxFunctionModel *model = [[BoxFunctionModel alloc] initWithDict:dict];
        [self.boxFunctionArray addObject:model];
    }
}

- (void)createUI {
    // 消除在iOS9上面scrollView顶部留有空白的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSInteger count = self.boxFunctionArray.count+1;
    if (count <= 4) {
        _boxViewH = 80;
    } else if (count <= 8) {
        _boxViewH = 80*2;
    } else {
        _boxViewH = 80*3;
    }
    [self.view addSubview:self.appView];
    self.appView.sizeHeight = _boxViewH;
}

- (void)refreshUI {
    [self.appView.collectionView reloadData];
    [self.appView refreshUI];
}

#pragma mark - BoxViewI700Delegate
- (void)itemClick:(NSInteger)itemId {
    if (itemId == 0) {
        MoreAppViewController *vc = [[MoreAppViewController alloc] init];
        vc.boxFuntionArray = self.boxFunctionArray;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@"点击了其他");
    }
}

#pragma mark - Lazy
- (BoxViewI700 *)appView {
    if (!_appView) {
        _appView = [[BoxViewI700 alloc] initWithFrame:CGRectMake(0, 100, kScreen_width, _boxViewH)];
        _appView.backgroundColor = [UIColor whiteColor];
        _appView.delegate = self;
        _appView.boxFunctionArray = self.boxFunctionArray;
    }
    return _appView;
}

- (NSMutableArray *)boxFunctionArray {
    if (!_boxFunctionArray) {
        _boxFunctionArray = [NSMutableArray array];
    }
    return _boxFunctionArray;
}


@end
