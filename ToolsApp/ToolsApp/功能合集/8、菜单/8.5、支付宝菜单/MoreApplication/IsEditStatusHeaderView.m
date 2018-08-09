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

@interface IsEditStatusHeaderView() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MoreAppCellDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *title;
//@property (nonatomic, strong) UIButton *completeButton;

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
//    [self addSubview:self.completeButton];
    [self addSubview:self.collectionView];
}

- (void)refreshUI {
    self.collectionView.frame = CGRectMake(0, titleH, self.frame.size.width, self.frame.size.height - titleH);
    [self.collectionView reloadData];
}

//- (void)completeButtonClick {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(completeButtonIsClick)]) {
//        [self.delegate completeButtonIsClick];
//    }
//}

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

#pragma mark - UIGestureRecognizerDelegate(手势)
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    //根据长按手势的状态进行处理。
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            //当没有点击到cell的时候不进行处理
            if (!indexPath) break;
            //开始移动
            [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            //cell.layer添加抖动手势
//            for (MoreAppCell *cell in [self.collectionView visibleCells]) {
//                [self starShake:cell];
//            }
            MoreAppCell *cell = (MoreAppCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
            [self starShake:cell];
            break;
        }
        case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            [_collectionView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
        {
            //停止移动调用此方法
            [_collectionView endInteractiveMovement];
            //cell.layer移除抖动手势
//            for (MoreAppCell *cell in [self.collectionView visibleCells]) {
//                [self stopShake:cell];
//            }
            MoreAppCell *cell = (MoreAppCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
            [self stopShake:cell];
            break;
        }
        default:
            //取消移动
            [_collectionView cancelInteractiveMovement];
            break;
    }
}

// 在开始移动时会调用此代理方法，
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexpath判断单元格是否可以移动，如果都可以移动，直接就返回YES ,不能移动的返回NO
    return YES;
}

// 在移动结束的时候调用此代理方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    
    if ([_delegate respondsToSelector:@selector(setupCollectionItem:oldIndexPath:toIndexpath:)]) {
        [_delegate setupCollectionItem:self oldIndexPath:sourceIndexPath toIndexpath:destinationIndexPath];
    }
    
}

// 开始抖动
- (void)starShake:(MoreAppCell*)cell{
    
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-3 / 180.0 * M_PI),@(3 /180.0 * M_PI),@(-3/ 180.0 * M_PI)];//度数转弧度
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.3;
    keyAnimaion.repeatCount = MAXFLOAT;
    [cell.layer addAnimation:keyAnimaion forKey:@"cellShake"];
}

// 停止抖动
- (void)stopShake:(MoreAppCell*)cell{
    [cell.layer removeAnimationForKey:@"cellShake"];
}

#pragma mark - Lazy
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, self.frame.size.width-24, titleH)];
//        _title.text = @"我的应用（按住拖动调整排序）";
        _title.textAlignment = NSTextAlignmentLeft;
        
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc]initWithString:@"我的应用（按住拖动调整排序）"];
        [titleString beginEditing];
        
        //字体大小
        [titleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, 4)];
        [titleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(4, 10)];
        
        //字体颜色
        [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
        [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(4, 10)];
        
        _title.attributedText = titleString;
    }
    return _title;
}

//- (UIButton *)completeButton {
//    if (!_completeButton) {
//        _completeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 0, 60, titleH)];
//        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
//        [_completeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [_completeButton addTarget:self action:@selector(completeButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        _completeButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    }
//    return _completeButton;
//}

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
        
        //添加手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPressGesture.minimumPressDuration = 0.3f;
        longPressGesture.delegate = self;
        [_collectionView addGestureRecognizer:longPressGesture];
    }
    return _collectionView;
}

@end
