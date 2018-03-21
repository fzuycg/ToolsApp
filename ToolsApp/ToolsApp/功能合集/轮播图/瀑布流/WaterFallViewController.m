//
//  WaterFallViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "WaterFallViewController.h"
#import "WaterFallCell.h"
#import "WaterFlowLayout.h"

static NSString *cellId = @"waterFallCell";

@interface WaterFallViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, WaterFlowLayoutDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation WaterFallViewController

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataArray addObjectsFromArray:[WaterFallDataModel mj_objectArrayWithFilename:@"2.plist"]];
    
    WaterFlowLayout *flowLayout = [[WaterFlowLayout alloc] init];
    flowLayout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[WaterFallCell class] forCellWithReuseIdentifier:cellId];
    
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
}


#pragma mark - UICollectionDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - UICollectionDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了");
}

#pragma mark - WaterFlowLayoutDelegate
-(CGFloat)waterflowLayout:(WaterFlowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    WaterFallDataModel *model = self.dataArray[indexPath.item];
    return model.h/model.w*itemWidth;
}

@end
