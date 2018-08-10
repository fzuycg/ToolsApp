//
//  MoreAppViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "MoreAppViewController.h"
#import "MoreAppCell.h"
#import "BoxFunctionModel.h"
#import "MoreAppModel.h"
#import "CollectionReusableFooterView.h"
#import "CollectionReusableHeaderView.h"
#import "IsEditStatusHeaderView.h"
#import "NoEditStatusHeaderView.h"
#import "UIView+Parameter.h"
#import "IsEditStatusNaviView.h"
#import "NoEditStatusNaviView.h"

static CGFloat headerViewH = 44; //初始的时候头视图的高度（未编辑状态）
static CGFloat sectionHeaderH = 40; //每个section头部高度
static CGFloat sectionFooterH = 0.5; //每个section底部的高度
static CGFloat itemH = 80; //cell的高度

static NSString *const cellId = @"MoreAppCell";
static NSString *const headerId = @"CollectionReusableFooterView";
static NSString *const footerId = @"CollectionReusableHeaderView";

@interface MoreAppViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, IsEditStatusHeaderViewDelegate, NoEditStatusHeaderViewDelegate, MoreAppCellDelegate, NoEditStatusNaviViewDelegate, IsEditStatusNaviViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IsEditStatusHeaderView *isEditHeaderView;
@property (nonatomic, strong) NoEditStatusHeaderView *noEditHeaderView;
@property (nonatomic, strong) IsEditStatusNaviView *isEditNaviView;
@property (nonatomic, strong) NoEditStatusNaviView *noEditNaviView;

@property (nonatomic, assign) BOOL isEditStatus; //是否处于编辑状态
@end

@implementation MoreAppViewController {
    CGFloat _showHeaderViewH; //编辑状态下头视图的高度
    CGFloat _collectionViewH; //collection的高度
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _isEditStatus = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)createUI {
    // 消除在iOS9上面scrollView顶部留有空白的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //计算collection的高度
    NSInteger sectionNum = self.groupFunctionArray.count;
    NSInteger allLineNum = 0;
    for (MoreAppModel *model in self.groupFunctionArray) {
        NSInteger appNum = model.modelArray.count;
        NSInteger lineNum = appNum / 4;
        NSInteger remainder = appNum % 4;
        if (remainder != 0) {
            lineNum += 1;
        }
        allLineNum += lineNum;
    }
    _collectionViewH = allLineNum * itemH + sectionNum * (sectionHeaderH + sectionFooterH);
    
    //计算编辑状态下头部视图的高度
    if (self.boxFunctionArray.count <= 4) {
        _showHeaderViewH = itemH + headerViewH;
    }else if (self.boxFunctionArray.count <= 8) {
        _showHeaderViewH = itemH*2 + headerViewH;
    }else{
        _showHeaderViewH = itemH*3 + headerViewH;
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.view addSubview:self.noEditNaviView];
    [self.view addSubview:self.isEditNaviView];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.collectionView];
    [self.scrollView addSubview:self.noEditHeaderView];
    [self.scrollView addSubview:self.isEditHeaderView];
    
    self.scrollView.contentSize = CGSizeMake(0, _collectionViewH + headerViewH);
    self.scrollView.scrollEnabled = YES;
    self.collectionView.scrollEnabled = NO;
}

- (void)setupUI {
    if (self.isEditStatus) {
        [self.scrollView setContentOffset:CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
        [UIView animateWithDuration:0.3 animations:^{
            self.noEditHeaderView.hidden = YES;
            self.isEditHeaderView.hidden = NO;
            self.collectionView.frame = CGRectMake(0, _showHeaderViewH, kScreen_width, self.scrollView.frame.size.height-_showHeaderViewH);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.noEditHeaderView.hidden = NO;
            self.isEditHeaderView.hidden = YES;
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                self.collectionView.frame = CGRectMake(0, headerViewH, kScreen_width, _collectionViewH);
            }];
        });
        
    }
}

- (void)refreshUI {
    CGFloat height = 0;
    if (self.boxFunctionArray.count <= 4) {
        height = itemH + headerViewH;
    }else if (self.boxFunctionArray.count <= 8) {
        height = itemH*2 + headerViewH;
    }else{
        height = itemH*3 + headerViewH;
    }
    
    //编辑头部行数发生改变
    if (_showHeaderViewH != height) {
        _showHeaderViewH = height;
        self.isEditHeaderView.sizeHeight = _showHeaderViewH;
        [self.isEditHeaderView refreshUI];
        self.collectionView.frame = CGRectMake(0, _showHeaderViewH, kScreen_width, self.scrollView.sizeHeight-_showHeaderViewH);
    }
}

- (void)setIsEditStatus:(BOOL)isEditStatus {
    _isEditStatus = isEditStatus;
    
    [self.collectionView reloadData];
    if (isEditStatus) {
        self.scrollView.scrollEnabled = NO;
        self.collectionView.scrollEnabled = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.isEditNaviView.hidden = NO;
        self.noEditNaviView.hidden = YES;
    }else{
        self.scrollView.scrollEnabled = YES;
        self.collectionView.scrollEnabled = NO;
        self.isEditNaviView.hidden = YES;
        self.noEditNaviView.hidden = NO;
    }
    [self setupUI];
}

#pragma mark -UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.groupFunctionArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    MoreAppModel *model = self.groupFunctionArray[section];
    return model.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    MoreAppModel *moreModel = self.groupFunctionArray[indexPath.section];
    BoxFunctionModel *model = moreModel.modelArray[indexPath.row];
    cell.model = model;
    cell.isEditStatus = self.isEditStatus;
    cell.delegate = self;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        MoreAppModel *model = self.groupFunctionArray[indexPath.section];
        headerView.sectionTitleText = model.sectionTitle;
        headerView.backgroundColor = [UIColor whiteColor];
//        if (indexPath.section == 0) {
//            headerView.isFirstSection = YES;
//        }else{
//            headerView.isFirstSection = NO;
//        }
        return headerView;
    }else{
        CollectionReusableFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if (indexPath.section == self.groupFunctionArray.count-1) {
            footerView.backgroundColor = [UIColor lightGrayColor];
        }else{
            footerView.backgroundColor = [UIColor whiteColor];
        }
        return footerView;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UICollectionViewFlowLayout
//每一个分组的上左下右间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

//设置每个section头部的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreen_width, sectionHeaderH);
}

//设置每个section底部的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreen_width, sectionFooterH);
}

#pragma mark - NoEditStatusNaviViewDelegate
// 返回按钮
- (void)backButtonIsClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - IsEditStatusNaviViewDelegate
// 取消按钮
- (void)cancelButtonIsClick {
    self.isEditStatus = NO;
    //需要在这里取消之前的数据操作
}

// 完成按钮
- (void)completeButtonIsClick {
    self.isEditStatus = NO;
    //这里上传之前的数据操作到服务端
}

#pragma mark - IsEditStatusHeaderViewDelegate
/**
 完成按钮
 */
//- (void)completeButtonIsClick {
//    self.isEditStatus = NO;
//}

/**
 删除按钮
 */
- (void)deleteButtonIsClick:(MoreAppCell *)cell functionId:(NSInteger)functionId {
    if (self.isEditHeaderView.boxFunctionArray.count <= 3) {
        NSLog(@"首页不能少于3个应用");
    }else{
        //1、拿到点击的位置
        NSIndexPath *indexPath = [self.isEditHeaderView.collectionView indexPathForCell:cell];
        //2、删除对应的元素（也可以根据对象删除）并更新各个数组数据
        [self.isEditHeaderView.boxFunctionArray removeObjectAtIndex:indexPath.row];
        self.boxFunctionArray = self.isEditHeaderView.boxFunctionArray;
        self.noEditHeaderView.boxFunctionArray = self.boxFunctionArray;
        //3、拿到相应的model
        BoxFunctionModel *model = cell.model;
        //4、刷新头部collectioView
        [self.isEditHeaderView.collectionView reloadData];
        [self.noEditHeaderView.collectionView reloadData];
        //5、找到修改状态的数据在全数组中的位置(--此处性能可能不好，有待优化--)
        NSInteger section = 0;
        NSInteger row = 0;
        for (int i=0; i<self.groupFunctionArray.count; i++) {
            MoreAppModel *moreModel = self.groupFunctionArray[i];
            /*
             //此方式遍历有问题，不在第一个数组的总是不存在
            if (![moreModel.modelArray containsObject:model]) {
                continue;
            }
            NSInteger j = [moreModel.modelArray indexOfObject:model];
            BoxFunctionModel *myModel = moreModel.modelArray[j];
            if (myModel.functionId == functionId) {
                section = i;
                row = j;
                break;
            }
             */
            for (int j=0; j < moreModel.modelArray.count; j++) {
                BoxFunctionModel *myModel = moreModel.modelArray[j];
                if (myModel.functionId == functionId) {
                    section = i;
                    row = j;
                    break;
                }
            }
        }
        
        //6、修改选中状态
        model.isSelectStatus = NO;
        //7、把修改后的替换进全部数组中
        MoreAppModel *moreModel = self.groupFunctionArray[section];
        [moreModel.modelArray replaceObjectAtIndex:row withObject:model];
        [self.groupFunctionArray replaceObjectAtIndex:section withObject:moreModel];
        
        //8、刷新全部应用collectionView
        [self.collectionView reloadData];
        //9、头部试图高度发生改变的话要进行修改
        [self refreshUI];
    }
}

/**
 拖拽结束
 */
- (void)setupCollectionItem:(IsEditStatusHeaderView *)headerView oldIndexPath:(NSIndexPath *)oldIndexPath toIndexpath:(NSIndexPath *)toIndexPath {
    BOOL canChange = self.isEditHeaderView.boxFunctionArray.count > oldIndexPath.item && self.isEditHeaderView.boxFunctionArray.count > toIndexPath.item;
    if (canChange) {
        /*
         此处不使用mutableCopy，由于深拷贝之后，返回上一页，数组内容就没有改变（但是使用内存关联的做法好像也是不太优雅）
         */
        NSMutableArray *tempArr = self.isEditHeaderView.boxFunctionArray;//[self.isEditHeaderView.boxFunctionArray mutableCopy];
        
        NSInteger activeRange = toIndexPath.item - oldIndexPath.item;
        BOOL moveForward = activeRange > 0;
        NSInteger originIndex = 0;
        NSInteger targetIndex = 0;
        
        for (NSInteger i = 1; i <= labs(activeRange); i ++) {
            
            NSInteger moveDirection = moveForward?1:-1;
            originIndex = oldIndexPath.item + i*moveDirection;
            targetIndex = originIndex  - 1*moveDirection;
            
            [tempArr exchangeObjectAtIndex:originIndex withObjectAtIndex:targetIndex];
        }
//        self.isEditHeaderView.boxFunctionArray = tempArr;//[tempArr mutableCopy];
//        self.boxFunctionArray = self.isEditHeaderView.boxFunctionArray;
//        self.noEditHeaderView.boxFunctionArray = self.boxFunctionArray;
        [self.noEditHeaderView.collectionView reloadData];
    }
}

#pragma mark - NoEditStatusHeaderViewDelegate
/**
 编辑按钮
 */
- (void)editButtonIsClick {
    self.isEditStatus = YES;
}

#pragma mark - MoreAppCellDelegate
/**
 添加按钮
 
在这里只是做添加的功能，目前不考虑在下部分删除功能（可以做删除）
 */
- (void)addButtonIsClick:(MoreAppCell *)cell functionId:(NSInteger)functionId {
    if (cell.isSelectStatus) {//已经选中的状态下
        return;
    }
    if (self.isEditHeaderView.boxFunctionArray.count >= 11) {
        NSLog(@"首页最多能添加11个应用");
    }else{
        //1、拿到点击的位置
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        //2、拿到相应的model
        MoreAppModel *moreModel = self.groupFunctionArray[indexPath.section];
        BoxFunctionModel *model = moreModel.modelArray[indexPath.row];
        //3、修改选中状态
        model.isSelectStatus = YES;
        //4、添加到选中的数组中，并更新各个数组数据
        [self.isEditHeaderView.boxFunctionArray addObject:model];
        self.boxFunctionArray = self.isEditHeaderView.boxFunctionArray;
        self.noEditHeaderView.boxFunctionArray = self.boxFunctionArray;
        //5、刷新头部collectioView
        [self.isEditHeaderView.collectionView reloadData];
        [self.noEditHeaderView.collectionView reloadData];
        //6、把修改后的替换进全部数组中
        [moreModel.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
        [self.groupFunctionArray replaceObjectAtIndex:indexPath.section withObject:moreModel];
        //7、刷新全部应用collectionView
        [self.collectionView reloadData];
        //8、头部试图高度发生改变的话要进行修改
        [self refreshUI];
    }
}

#pragma mark - Lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Navigation_HEIGHT, kScreen_width, kScreen_height-Navigation_HEIGHT)];
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = 0;
        //设置sectionHeader滑动悬浮(这是在iOS9之后才出现的)
        layout.sectionHeadersPinToVisibleBounds = YES;
        //设置sectionFooter滑动悬浮
        layout.sectionFootersPinToVisibleBounds = YES;
        //最小两行之间的间距
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(kScreen_width/5, itemH);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headerViewH, kScreen_width, _collectionViewH) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MoreAppCell class] forCellWithReuseIdentifier:cellId];
        [_collectionView registerClass:[CollectionReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [_collectionView registerClass:[CollectionReusableFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    }
    return _collectionView;
}

- (NSMutableArray *)boxFunctionArray {
    if (!_boxFunctionArray) {
        _boxFunctionArray = [NSMutableArray array];
    }
    return _boxFunctionArray;
}

- (NSMutableArray *)groupFunctionArray {
    if (!_groupFunctionArray) {
        _groupFunctionArray = [NSMutableArray array];
    }
    return _groupFunctionArray;
}

- (NoEditStatusHeaderView *)noEditHeaderView {
    if (!_noEditHeaderView) {
        _noEditHeaderView = [[NoEditStatusHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, headerViewH)];
        _noEditHeaderView.delegate = self;
        _noEditHeaderView.boxFunctionArray = self.boxFunctionArray;
    }
    return _noEditHeaderView;
}

- (IsEditStatusHeaderView *)isEditHeaderView {
    if (!_isEditHeaderView) {
        _isEditHeaderView = [[IsEditStatusHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, _showHeaderViewH)];
        _isEditHeaderView.delegate = self;
        _isEditHeaderView.hidden = YES;
        _isEditHeaderView.boxFunctionArray = self.boxFunctionArray;
    }
    return _isEditHeaderView;
}

- (NoEditStatusNaviView *)noEditNaviView {
    if (!_noEditNaviView) {
        _noEditNaviView = [[NoEditStatusNaviView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, Navigation_HEIGHT)];
        _noEditNaviView.delegate = self;
    }
    return _noEditNaviView;
}

- (IsEditStatusNaviView *)isEditNaviView {
    if (!_isEditNaviView) {
        _isEditNaviView = [[IsEditStatusNaviView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, Navigation_HEIGHT)];
        _isEditNaviView.delegate = self;
        _isEditNaviView.hidden = YES;
    }
    return _isEditNaviView;
}

@end
