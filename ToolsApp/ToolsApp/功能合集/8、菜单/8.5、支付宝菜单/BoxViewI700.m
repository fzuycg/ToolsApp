//
//  BoxViewI700.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/26.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "BoxViewI700.h"
#import "BoxFunctionCell.h"
#import "BoxFunctionModel.h"

@interface BoxViewI700 () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

static NSString *const cellId = @"BoxFunctionCell";

@implementation BoxViewI700

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    [self addSubview:self.collectionView];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.boxFunctionArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BoxFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (indexPath.row == self.boxFunctionArray.count) {
        BoxFunctionModel *model = [[BoxFunctionModel alloc] init];
        model.title = @"更多";
        model.image = [UIImage imageNamed:@"等等等.png"];
        cell.model = model;
        return cell;
    }else{
        BoxFunctionModel *model = self.boxFunctionArray[indexPath.row];
        cell.model = model;
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemId = 0;
    if (indexPath.row < self.boxFunctionArray.count) {
        BoxFunctionModel *model = self.boxFunctionArray[indexPath.row];
        itemId = model.functionId;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemClick:)]) {
        [self.delegate itemClick:itemId];
    }
}

#pragma mark - UICollectionViewFlowLayout
//每一个分组的上左下右间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


#pragma mark - Lazy
- (NSMutableArray *)boxFunctionArray {
    if (!_boxFunctionArray) {
        _boxFunctionArray = [NSMutableArray array];
        
    }
    return _boxFunctionArray;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        _layout.minimumInteritemSpacing = 0;
        //最小两行之间的间距
        _layout.minimumLineSpacing = 0;
        _layout.itemSize = CGSizeMake(kScreen_width/5, 80);
    }
    return _layout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[BoxFunctionCell class] forCellWithReuseIdentifier:cellId];
    }
    return _collectionView;
}

@end
