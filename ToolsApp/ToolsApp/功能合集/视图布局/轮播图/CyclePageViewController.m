//
//  CyclePageViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CyclePageViewController.h"
#import "CycleImageView.h"
#import "CycleImageModel.h"

@interface CyclePageViewController () <CycleImageViewDelegate>
@property (nonatomic, weak) CycleImageView *cycleView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CyclePageViewController

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self loadData];
}

- (void)createUI {
    CycleImageView *cycleView = [[CycleImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, kScreen_width, 250)];
    cycleView.delegate = self;
    [self.view addSubview:cycleView];
    self.cycleView = cycleView;
}

- (void)loadData {
//    NSArray *array = @[
//                       @{@"imageUrl":@"i1.jpg",@"imageTip":@"AAAAA"},
//                       @{@"imageUrl":@"i2.jpg",@"imageTip":@"BBBBBB"},
//                       @{@"imageUrl":@"i3.jpg",@"imageTip":@"CCCCCC"},
//                       @{@"imageUrl":@"i4.jpg",@"imageTip":@"DDDDDD"},
//                       @{@"imageUrl":@"i5.jpg",@"imageTip":@"EEEEEE"},
//                       ];
//
//    [self.dataArray addObjectsFromArray:[CycleImageModel mj_objectArrayWithKeyValuesArray:array]];
    [self.dataArray addObjectsFromArray:[CycleImageModel mj_objectArrayWithFilename:@"cycleImage.plist"]];
    self.cycleView.dataArray = self.dataArray;
}

#pragma mark - CycleImageViewDelegate
- (void)didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%ld",(long)index);
}

@end
