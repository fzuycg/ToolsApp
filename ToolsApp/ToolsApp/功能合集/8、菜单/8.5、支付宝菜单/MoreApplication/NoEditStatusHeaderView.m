//
//  NoEditStatusHeaderView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "NoEditStatusHeaderView.h"
#import "NoEditStatusHeaderCell.h"
#import "BoxFunctionModel.h"

static NSString *const cellId = @"NoEditStatusHeaderCell";

@interface NoEditStatusHeaderView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *editButton;

@end

@implementation NoEditStatusHeaderView {
    CGFloat _collectionViewW; //collectionView的宽
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    //计算collectionView的宽度
    _collectionViewW = self.frame.size.width - self.title.frame.size.width - self.editButton.frame.size.width;
    
    [self addSubview:self.title];
    [self addSubview:self.editButton];
    [self addSubview:self.collectionView];
}

- (void)editButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editButtonIsClick)]) {
        [self.delegate editButtonIsClick];
    }
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.boxFunctionArray.count > 7) {
        return 7;
    }else{
        return self.boxFunctionArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NoEditStatusHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (self.boxFunctionArray.count > 7 && indexPath.row == 6) {
        cell.image = [UIImage imageNamed:@"等等等.png"];
    }else{
        BoxFunctionModel *model = self.boxFunctionArray[indexPath.row];
        cell.image = model.image;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UICollectionViewFlowLayout
//每一个分组的上左下右间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - Lazy
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, self.frame.size.height)];
        _title.text = @"首页";
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 0, 60, self.frame.size.height)];
        [_editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _editButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = 0;
        //最小两行之间的间距
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(_collectionViewW/7, self.frame.size.height);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.title.frame.size.width, 0, _collectionViewW, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[NoEditStatusHeaderCell class] forCellWithReuseIdentifier:cellId];
    }
    return _collectionView;
}


@end
