//
//  CardLayoutView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CardLayoutView.h"
#import "CardLayoutCell.h"
#import "CardFlowLayout.h"

#define kCellIdentifier     @"CardLayoutCell"

@interface CardLayoutView() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CardLayoutView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSourece
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    CycleImageModel *model = self.dataArray[indexPath.item];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delagate && [self.delagate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.delagate didSelectItemAtIndex:indexPath.item];
    }
}

#pragma mark - setter and getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CardFlowLayout *flowLayout = [[CardFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;        //开启分页
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[CardLayoutCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor purpleColor];
        [self addSubview:_collectionView];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

@end
