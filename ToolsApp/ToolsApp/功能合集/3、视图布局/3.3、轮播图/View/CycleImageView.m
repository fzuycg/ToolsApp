//
//  CycleImageView.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CycleImageView.h"
#import "CycleImageViewPageControl.h"
#import "CycleImageViewCell.h"

#define kPageControl_H      40
#define kCellIdentifier     @"CycleImageViewCell"

@interface CycleImageView() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CycleImageViewPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CycleImageView {
    NSInteger _index;
    BOOL _isScrol;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    CycleImageModel *model = self.dataArray[indexPath.item];
    cell.model = model;
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_isScrol) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        _isScrol = NO;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    currentPage = currentPage % self.dataArray.count;
    
    self.pageControl.currentPage = currentPage;
    _index = currentPage;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentPage inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        [self.delegate didSelectItemAtIndex:indexPath.row];
    }
}

#pragma mark - timer action
- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerCycleImageAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)timerCycleImageAction:(NSTimer *)timer
{
    if (_index == self.dataArray.count) {
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.pageControl.currentPage = 0;
        _index = 1;
        _isScrol = YES;
        
    }else
    {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.pageControl.currentPage = _index;
        _index += 1;
    }
}

#pragma mark - setter and getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;        //开启分页
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[CycleImageViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    return _collectionView;
}

- (CycleImageViewPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[CycleImageViewPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - kPageControl_H, self.bounds.size.width, kPageControl_H)];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.enabled = NO;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = dataArray.count;
    [self startTimer];
}

#pragma mark - dealloc
- (void)dealloc
{
    [self stopTimer];
}

@end
