//
//  CardLayoutViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CardLayoutViewController.h"
#import "CardLayoutView.h"
#import "CycleImageModel.h"

@interface CardLayoutViewController () <CardLayoutViewDelegate>
@property (nonatomic, weak) CardLayoutView *cardLayoutView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CardLayoutViewController

- (NSMutableArray *)dataArray {
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
    CardLayoutView *cardLayoutView = [[CardLayoutView alloc] initWithFrame:self.view.bounds];
    cardLayoutView.delagate = self;
    cardLayoutView.pagingEnabled = YES;
    [self.view addSubview:cardLayoutView];
    self.cardLayoutView = cardLayoutView;
    
    UIButton *previousBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, kScreen_height-30, 60, 30)];
    [previousBtn setTitle:@"上一张" forState:UIControlStateNormal];
    [previousBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [previousBtn addTarget:self action:@selector(previousBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cardLayoutView addSubview:previousBtn];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_width-70, kScreen_height-30, 60, 30)];
    [nextBtn setTitle:@"下一张" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cardLayoutView addSubview:nextBtn];
}

- (void)previousBtnClick {
    NSInteger index = self.cardLayoutView.selectedIndex - 1;
    index = index < 0 ? 0 : index;
    [self.cardLayoutView switchToIndex:index animated:true];
}

- (void)nextBtnClick {
    NSInteger index = self.cardLayoutView.selectedIndex + 1;
    index = index > self.cardLayoutView.dataArray.count - 1 ? self.cardLayoutView.dataArray.count - 1 : index;
    [self.cardLayoutView switchToIndex:index animated:true];
}

- (void)loadData {
    NSArray *array = @[
                       @{@"imageUrl":@"i1.jpg",@"imageTip":@"AAAAA"},
                       @{@"imageUrl":@"i2.jpg",@"imageTip":@"BBBBBB"},
                       @{@"imageUrl":@"i3.jpg",@"imageTip":@"CCCCCC"},
                       @{@"imageUrl":@"i4.jpg",@"imageTip":@"DDDDDD"},
                       ];
    
    [self.dataArray addObjectsFromArray:[CycleImageModel mj_objectArrayWithKeyValuesArray:array]];
//    [self.dataArray addObjectsFromArray:[CycleImageModel mj_objectArrayWithFilename:@"cycleImage.plist"]];
    self.cardLayoutView.dataArray = self.dataArray;
}

#pragma mark - CardLayoutViewDelegate
- (void)didSelectItemAtIndex:(NSInteger)index {
    DeLog(@"点击了%ld",(long)index);
}

@end
