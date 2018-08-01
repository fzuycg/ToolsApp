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

static CGFloat headerViewH = 44; //初始的时候头视图的高度（未编辑状态）
static CGFloat sectionHeaderH = 40; //每个section头部高度
static CGFloat sectionFooterH = 0.5; //每个section底部的高度

static NSString *const cellId = @"MoreAppCell";
static NSString *const headerId = @"CollectionReusableFooterView";
static NSString *const footerId = @"CollectionReusableHeaderView";

@interface MoreAppViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, IsEditStatusHeaderViewDelegate, NoEditStatusHeaderViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IsEditStatusHeaderView *isEditHeaderView;
@property (nonatomic, strong) NoEditStatusHeaderView *noEditHeaderView;

@property (nonatomic, strong) NSMutableArray *groupFunctionArray; //全部功能数组
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
    [self readData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createUI];
}

- (void)readData {
    //JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AllFunction" ofType:@"json"];
    
    //加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //将JSON数据转为NSArray或NSDictionary
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dict in dictArray) {
        MoreAppModel *model = [[MoreAppModel alloc] initWithDict:dict];
        [self.groupFunctionArray addObject:model];
    }
    
    _isEditStatus = NO;
}

- (void)createUI {
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
    
    _collectionViewH = allLineNum * 80 + sectionNum * (sectionHeaderH + sectionFooterH);
    
    //计算编辑状态下头部视图的高度
    if (self.boxFuntionArray.count <= 4) {
        _showHeaderViewH = 80 + headerViewH;
    }else if (self.boxFuntionArray.count <= 8) {
        _showHeaderViewH = 80*2 + headerViewH;
    }else{
        _showHeaderViewH = 80*3 + headerViewH;
    }
    
    //给标题栏添加搜索框
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width-50, 40)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchView.bounds];
    searchBar.placeholder = @"搜索";
    [searchView addSubview:searchBar];
    self.navigationItem.titleView = searchView;
    
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

- (void)setIsEditStatus:(BOOL)isEditStatus {
    _isEditStatus = isEditStatus;
    
    [self.collectionView reloadData];
    if (isEditStatus) {
        self.scrollView.scrollEnabled = NO;
        self.collectionView.scrollEnabled = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
    }else{
        self.scrollView.scrollEnabled = YES;
        self.collectionView.scrollEnabled = NO;
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
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        MoreAppModel *model = self.groupFunctionArray[indexPath.section];
        headerView.sectionTitleText = model.sectionTitle;
        if (indexPath.section == 0) {
            headerView.isFirstSection = YES;
        }else{
            headerView.isFirstSection = NO;
        }
        return headerView;
    }else{
        CollectionReusableFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor lightGrayColor];
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

#pragma mark - IsEditStatusHeaderViewDelegate
- (void)completeButtonIsClick {
    self.isEditStatus = NO;
}

#pragma mark - NoEditStatusHeaderViewDelegate
- (void)editButtonIsClick {
    self.isEditStatus = YES;
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
        //最小两行之间的间距
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(kScreen_width/5, 80);
        
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
        _noEditHeaderView.boxFunctionArray = self.boxFuntionArray;
    }
    return _noEditHeaderView;
}

- (IsEditStatusHeaderView *)isEditHeaderView {
    if (!_isEditHeaderView) {
        _isEditHeaderView = [[IsEditStatusHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, _showHeaderViewH)];
        _isEditHeaderView.delegate = self;
        _isEditHeaderView.hidden = YES;
        _isEditHeaderView.boxFunctionArray = self.boxFuntionArray;
    }
    return _isEditHeaderView;
}

@end
