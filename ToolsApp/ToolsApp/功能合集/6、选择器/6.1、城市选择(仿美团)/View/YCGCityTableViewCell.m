//
//  YCGCityTableViewCell.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGCityTableViewCell.h"
#import "YCGCityCollectionViewCell.h"
#import "YCGCityCollectionViewFlowLayout.h"

NSString * const YCGCityTableViewCellDidChangeCityNotification = @"YCGCityTableViewCellDidChangeCityNotification";
static NSString *cellID = @"cityConllectionViewCell";

@interface YCGCityTableViewCell() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YCGCityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cityNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YCGCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.title = _cityNameArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cityName = _cityNameArray[indexPath.row];
    NSDictionary *cityNameDic = @{@"cityName":cityName};
    [[NSNotificationCenter defaultCenter] postNotificationName:YCGCityTableViewCellDidChangeCityNotification object:self userInfo:cityNameDic];
}

#pragma mark - setter && getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[YCGCityCollectionViewFlowLayout alloc] init]];
        [_collectionView registerClass:[YCGCityCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = YCGRGBAColor(247, 247, 247, 1.0);
    }
    return _collectionView;
}

- (void)setCityNameArray:(NSArray *)cityNameArray {
    _cityNameArray = cityNameArray;
    [_collectionView reloadData];
}

@end
