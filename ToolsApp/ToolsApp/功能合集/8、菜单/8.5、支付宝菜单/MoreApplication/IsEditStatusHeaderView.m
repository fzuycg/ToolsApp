//
//  IsEditStatusHeaderView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "IsEditStatusHeaderView.h"
#import "MoreAppCell.h"
#import "BoxFunctionModel.h"

static CGFloat titleH = 44;
static NSString *const cellId = @"MoreAppCell";

@interface IsEditStatusHeaderView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, IsEditStatusHeaderViewDelegate, MoreAppCellDelegate>
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *completeButton;

@end

@implementation IsEditStatusHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.title];
    [self addSubview:self.completeButton];
    [self addSubview:self.collectionView];
}

- (void)refreshUI {
    self.collectionView.frame = CGRectMake(0, titleH, self.frame.size.width, self.frame.size.height - titleH);
    [self.collectionView reloadData];
}

- (void)completeButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(completeButtonIsClick)]) {
        [self.delegate completeButtonIsClick];
    }
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.boxFunctionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    BoxFunctionModel *model = self.boxFunctionArray[indexPath.row];
    cell.model = model;
    cell.isEditStatus = YES;
//    cell.isSelectStatus = YES;
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UICollectionViewFlowLayout
//每一个分组的上左下右间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark - MoreAppCellDelegate
/**
 这里只有删除功能
 */
- (void)addButtonIsClick:(MoreAppCell *)cell functionId:(NSInteger)functionId {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteButtonIsClick:functionId:)]) {
        [self.delegate deleteButtonIsClick:cell functionId:functionId];
    }
}

#pragma mark - Lazy
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, titleH)];
        _title.text = @"首页";
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 0, 60, titleH)];
        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_completeButton addTarget:self action:@selector(completeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _completeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _completeButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = 0;
        //最小两行之间的间距
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(kScreen_width/5, 80);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, titleH, kScreen_width, self.frame.size.height-titleH) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MoreAppCell class] forCellWithReuseIdentifier:cellId];
    }
    return _collectionView;
}

@end
