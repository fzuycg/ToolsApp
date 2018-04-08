//
//  YCGCityViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "YCGCityViewController.h"
#import "YCGCityHeaderView.h"
#import "YCGCitySearchView.h"
#import "YCGCityTableViewCell.h"
#import "YCGAreaDataManager.h"
#import "YCGLocationManager.h"

#define kCurrentCityInfoDefaults [NSUserDefaults standardUserDefaults]

@interface YCGCityViewController () <YCGLocationManagerDelegate, YCGCityHeaderViewDelegate, YCGCitySearchViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YCGAreaDataManager *areaDataManager;
@property (nonatomic, strong) YCGLocationManager *locationManager;
@property (nonatomic, strong) YCGCitySearchView *searchView;
@property (nonatomic, strong) YCGCityTableViewCell *tableViewCell;
@property (nonatomic, strong) YCGCityHeaderView *headerView;

/** 最近访问的城市*/
@property (nonatomic, strong) NSMutableArray *historyCityMutableArray;
/** 热门城市*/
@property (nonatomic, strong) NSArray *hotCityArray;
/** 字母索引*/
@property (nonatomic, strong) NSMutableArray *characterMutableArray;
/** 所有“市”级城市名称*/
@property (nonatomic, strong) NSMutableArray *cityMutableArray;
/** 根据cityNumber在数据库中查到的区县*/
@property (nonatomic, strong) NSMutableArray *areaMutableArray;
@end

@implementation YCGCityViewController {
    NSMutableArray   *_indexMutableArray;           //存字母索引下标数组
    NSMutableArray   *_sectionMutableArray;         //存处理过以后的数组
    NSInteger        _HeaderSectionTotal;           //头section的个数
    CGFloat          _cellHeight;                   //添加的(显示区县名称)cell的高度
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _HeaderSectionTotal = 3;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseCityWithName:) name:YCGCityTableViewCellDidChangeCityNotification object:nil];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    
    [self backBarButtonItem];
    [self initWithAreaDataManaager];
    
    _indexMutableArray = [NSMutableArray array];
    _sectionMutableArray = [NSMutableArray array];
    
    if ([kCurrentCityInfoDefaults objectForKey:@"cityData"]) {
        self.characterMutableArray = [NSKeyedUnarchiver unarchiveObjectWithData:[kCurrentCityInfoDefaults objectForKey:@"cityData"]];
        _sectionMutableArray = [NSKeyedUnarchiver unarchiveObjectWithData:[kCurrentCityInfoDefaults objectForKey:@"sectionData"]];
        [_tableView reloadData];
    }else {
        //在子线程中异步执行汉字转拼音再转汉字耗时操作
        dispatch_queue_t serialQueue = dispatch_queue_create("com.city.www", DISPATCH_QUEUE_SERIAL);
        dispatch_async(serialQueue, ^{
            [self processData:^(id success) {
                //回到主线程刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                    self.locationManager = [[YCGLocationManager alloc] init];
                    _locationManager.delegate = self;
                });
            }];
        });
    }
    
    self.historyCityMutableArray = [NSKeyedUnarchiver unarchiveObjectWithData:[kCurrentCityInfoDefaults objectForKey:@"historyCity"]];
}

- (void)backBarButtonItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_item_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithRed:0.5 green:0.5 blue:0.8 alpha:1]];
}

- (void)backBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 初始化数据库，获取所有“市”级城市名称
- (void)initWithAreaDataManaager {
    _areaDataManager = [YCGAreaDataManager shareManager];
    [_areaDataManager areaSqliteDBData];
    __weak typeof(self) weakSelf = self;
    [_areaDataManager cityData:^(NSMutableArray *dataArray) {
        //立刻生成一个strong引用，以保证实例在执行期间持续存活
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.cityMutableArray = dataArray;
        }
    }];
}

/// 选择城市时调用通知函数（前提是点击cell的section < 3）
- (void)chooseCityWithName:(NSNotification *)info {
    NSDictionary *cityDic = info.userInfo;
    NSString *cityName = [[NSString alloc] init];
    if ([[cityDic valueForKey:@"cityName"] isEqualToString:@"全城"]) {
        __weak typeof(self) weakSelf = self;
        [_areaDataManager currentCity:[kCurrentCityInfoDefaults objectForKey:@"cityNumber"] currentCityName:^(NSString *name) {
            [kCurrentCityInfoDefaults setObject:name forKey:@"currentCity"];
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                strongSelf.headerView.cityName = name;
                if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(cityName:)]) {
                    [strongSelf.delegate cityName:name];
                }
            }
            
        }];
    }else {
        cityName = [cityDic valueForKey:@"cityName"];
        _headerView.cityName = cityName;
        [kCurrentCityInfoDefaults setObject:[cityDic valueForKey:@"cityName"] forKey:@"currentCity"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(cityName:)]) {
            [self.delegate cityName:cityName];
        }
        [_areaDataManager cityNumberWithCity:[cityDic valueForKey:@"cityName"] cityNumber:^(NSString *cityNumber) {
            [kCurrentCityInfoDefaults setObject:cityNumber forKey:@"cityNumber"];
        }];
        
        [self historyCity:cityName];
    }
    
    //销毁通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _characterMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section < _HeaderSectionTotal ? 1 : [_sectionMutableArray[0][_characterMutableArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _HeaderSectionTotal) {
        self.tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
        if (_HeaderSectionTotal == 4 && indexPath.section == 0) {
            _tableViewCell.cityNameArray = _areaMutableArray;
        }
        if (indexPath.section == _HeaderSectionTotal - 3) {
            NSString *locationCity = [kCurrentCityInfoDefaults objectForKey:@"locationCity"];
            _tableViewCell.cityNameArray = locationCity ? @[locationCity] : @[@"正在定位..."];
        }
        if (indexPath.section == _HeaderSectionTotal - 2) {
            _tableViewCell.cityNameArray = self.historyCityMutableArray;
        }
        if (indexPath.section == _HeaderSectionTotal - 1) {
            _tableViewCell.cityNameArray = self.hotCityArray;
        }
        return _tableViewCell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityNameCell" forIndexPath:indexPath];
        NSArray *currentArray = _sectionMutableArray[0][_characterMutableArray[indexPath.section]];
        cell.textLabel.text = currentArray[indexPath.row];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_HeaderSectionTotal == 4 && indexPath.section == 0) {
        return _cellHeight;
    }else {
        return indexPath.section == (_HeaderSectionTotal - 1) ? 200 : 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_HeaderSectionTotal == 4 && section == 0) {
        return 0;
    }else{
        return 40;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_HeaderSectionTotal == 3) {
        switch (section) {
            case 0:
                return @"定位城市";
                break;
            case 1:
                return @"最近访问的城市";
                break;
            case 2:
                return @"热门城市";
                break;
            default:
                return _characterMutableArray[section];
                break;
        }
    }else {
        switch (section) {
            case 1:
                return @"定位城市";
                break;
            case 2:
                return @"最近访问的城市";
                break;
            case 3:
                return @"热门城市";
                break;
            default:
                return _characterMutableArray[section];
                break;
        }
    }
}

//设置右侧索引的标题，这里返回的是一个数组哦！
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _characterMutableArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _headerView.cityName = cell.textLabel.text;
    [kCurrentCityInfoDefaults setObject:cell.textLabel.text forKey:@"currentCity"];
    [_areaDataManager cityNumberWithCity:cell.textLabel.text cityNumber:^(NSString *cityNumber) {
        [kCurrentCityInfoDefaults setObject:cityNumber forKey:@"cityNumber"];
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cityName:)]) {
        [self.delegate cityName:cell.textLabel.text];
    }
    [self historyCity:cell.textLabel.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - YCGLocationManagerDelegate
- (void)locating {
    NSLog(@"定位中...");
}

- (void)currentLocation:(NSDictionary *)dictionary {
    NSString *city = [dictionary valueForKey:@"City"];
    [kCurrentCityInfoDefaults setObject:city forKey:@"locationCity"];
    [_areaDataManager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
        [kCurrentCityInfoDefaults setObject:cityNumber forKey:@"cityNumber"];
    }];
    _headerView.cityName = city;
    [self historyCity:city];
    [_tableView reloadData];
}


- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@...",message);
}

- (void)locateFailure:(NSString *)message {
    NSLog(@"%@...",message);
}

#pragma mark - YCGCityHeaderViewDelegate
- (void)cityNameWithSelected:(BOOL)selected {
    //获取当前市/区
    NSString *cityName = [kCurrentCityInfoDefaults objectForKey:@"currentCity"] ? [kCurrentCityInfoDefaults objectForKey:@"currentCity"] : [kCurrentCityInfoDefaults objectForKey:@"locationCity"];
    BOOL isbool = [_cityMutableArray containsObject: cityName];//判断当前选择的是否为地级市
    if (!isbool) return;
    
    //获取当前城市的所有辖区
    if (selected) {
        [_areaDataManager areaData:[kCurrentCityInfoDefaults objectForKey:@"cityNumber"] areaData:^(NSMutableArray *areaData) {
            [self.areaMutableArray addObjectsFromArray:areaData];
            if (0 == (self.areaMutableArray.count % 3)) {
                _cellHeight = self.areaMutableArray.count / 3 * 50;
            }else {
                _cellHeight = (self.areaMutableArray.count / 3 + 1) * 50;
            }
            if (_cellHeight > 300) {
                _cellHeight = 300;
            }
        }];
        
        //添加一行cell
        [_tableView endUpdates];
        [_characterMutableArray insertObject:@"*" atIndex:0];
        _HeaderSectionTotal = 4;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [_tableView endUpdates];
    }else {
        //清空区县名称数组
        self.areaMutableArray = nil;
        //删除一行cell
        [_tableView endUpdates];
        [_characterMutableArray removeObjectAtIndex:0];
        _HeaderSectionTotal = 3;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [_tableView endUpdates];
    }
}
- (void)beginSearch {
    [self.view addSubview:self.searchView];
}
- (void)endSearch {
    [self deleteSearchView];
}
- (void)searchText:(NSString *)text {
    [_areaDataManager searchCityData:text result:^(NSMutableArray *result) {
        if ([result count] > 0) {
            _searchView.backgroundColor = [UIColor whiteColor];
            _searchView.resultArray = result;
        }
    }];
}

#pragma mark - YCGCitySearchViewDelegate
- (void)searchResults:(NSDictionary *)results {
    [kCurrentCityInfoDefaults setObject:[results valueForKey:@"city"] forKey:@"currentCity"];
    [kCurrentCityInfoDefaults setObject:[results valueForKey:@"city_number"] forKey:@"cityNumber"];
    NSString *nameStr = [results valueForKey:@"city"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cityName:)]) {
        [self.delegate cityName:nameStr];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self historyCity:[results valueForKey:@"city"]];
}

- (void)touchViewToExit {
    [_headerView cancelSearch];
}

#pragma mark - private
/// 添加历史访问城市
- (void)historyCity:(NSString *)city {
    //避免重复添加，先删除再添加
    [_historyCityMutableArray removeObject:city];
    [_historyCityMutableArray insertObject:city atIndex:0];
    if (_historyCityMutableArray.count > 3) {
        [_historyCityMutableArray removeLastObject];
    }
    NSData *historyCityData = [NSKeyedArchiver archivedDataWithRootObject:self.historyCityMutableArray];
    [kCurrentCityInfoDefaults setObject:historyCityData forKey:@"historyCity"];
}

/// 移除搜索界面
- (void)deleteSearchView {
    [_searchView removeFromSuperview];
    _searchView = nil;
}

/// 汉字转拼音再转成汉字
-(void)processData:(void (^) (id))success {
    for (int i = 0; i < _cityMutableArray.count; i ++) {
        NSString *str = _cityMutableArray[i]; //一开始的内容
        if (str.length) {  //下面那2个转换的方法一个都不能少
            NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
            //汉字转拼音
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            }
            //拼音转英文
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
                //字符串截取第一位，并转换成大写字母
                NSString *firstStr = [[ms substringToIndex:1] uppercaseString];
                //如果不是字母开头的，转为＃
                BOOL isLetter = [self matchLetter:firstStr];
                if (!isLetter)
                    firstStr = @"#";
                
                //如果还没有索引
                if (_indexMutableArray.count <= 0) {
                    //保存当前这个做索引
                    [_indexMutableArray addObject:firstStr];
                    //用这个字母做字典的key，将当前的标题保存到key对应的数组里面去
                    NSMutableArray *array = [NSMutableArray arrayWithObject:str];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:array,firstStr, nil];
                    [_sectionMutableArray addObject:dic];
                }else{
                    //如果索引里面包含了当前这个字母，直接保存数据
                    if ([_indexMutableArray containsObject:firstStr]) {
                        //取索引对应的数组，保存当前标题到数组里面
                        NSMutableArray *array = _sectionMutableArray[0][firstStr];
                        [array addObject:str];
                        //重新保存数据
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:array,firstStr, nil];
                        [_sectionMutableArray addObject:dic];
                    }else{
                        //如果没有包含，说明是新的索引
                        [_indexMutableArray addObject:firstStr];
                        //用这个字母做字典的key，将当前的标题保存到key对应的数组里面去
                        NSMutableArray *array = [NSMutableArray arrayWithObject:str];
                        NSMutableDictionary *dic = _sectionMutableArray[0];
                        [dic setObject:array forKey:firstStr];
                        [_sectionMutableArray addObject:dic];
                    }
                }
            }
        }
    }
    
    //将字母排序
    NSArray *compareArray = [[_sectionMutableArray[0] allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _indexMutableArray = [NSMutableArray arrayWithArray:compareArray];
    
    //判断第一个是不是字母，如果不是放到最后一个
    BOOL isLetter = [self matchLetter:_indexMutableArray[0]];
    if (!isLetter) {
        //获取数组的第一个元素
        NSString *firstStr = [_indexMutableArray firstObject];
        //移除第一项元素
        [_indexMutableArray removeObjectAtIndex:0];
        //插入到最后一个位置
        [_indexMutableArray insertObject:firstStr atIndex:_indexMutableArray.count];
    }
    
    [self.characterMutableArray addObjectsFromArray:_indexMutableArray];
    NSData *cityData = [NSKeyedArchiver archivedDataWithRootObject:self.characterMutableArray];
    NSData *sectionData = [NSKeyedArchiver archivedDataWithRootObject:_sectionMutableArray];
    
    //拼音转换太耗时，这里把第一次转换结果存到单例中
    [kCurrentCityInfoDefaults setValue:cityData forKey:@"cityData"];
    [kCurrentCityInfoDefaults setObject:sectionData forKey:@"sectionData"];
    success(@"成功");
}

/// 匹配是不是字母开头
- (BOOL)matchLetter:(NSString *)str {
    //判断是否以字母开头
    NSString *ZIMU = @"^[A-Za-z]+$";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    
    if ([regextestA evaluateWithObject:str] == YES)
        return YES;
    else
        return NO;
}

- (void)dealloc {
    
}

#pragma mark - setter && getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexColor = [UIColor colorWithRed:0/255.0f green:132/255.0f blue:255/255.0f alpha:1];
        [_tableView registerClass:[YCGCityTableViewCell class] forCellReuseIdentifier:@"cityCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityNameCell"];
    }
    return _tableView;
}

- (NSMutableArray *)areaMutableArray {
    if (!_areaMutableArray) {
        _areaMutableArray = [NSMutableArray arrayWithObject:@"全城"];
    }
    return _areaMutableArray;
}

- (YCGCityHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[YCGCityHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
        _headerView.delegate = self;
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.btnTitle = @"选择区县";
        _headerView.cityName = [kCurrentCityInfoDefaults objectForKey:@"currentCity"] ? [kCurrentCityInfoDefaults objectForKey:@"currentCity"] : [kCurrentCityInfoDefaults objectForKey:@"locationCity"];
    }
    return _headerView;
}

- (YCGCitySearchView *)searchView {
    if (!_searchView) {
        CGRect frame = [UIScreen mainScreen].bounds;
        _searchView = [[YCGCitySearchView alloc] initWithFrame:CGRectMake(0, 104, frame.size.width, frame.size.height  - 104)];
        _searchView.backgroundColor = [UIColor colorWithRed:155 / 255.0 green:155 / 255.0 blue:155 / 255.0 alpha:0.5];
        _searchView.delegate = self;
    }
    return _searchView;
}

- (NSMutableArray *)historyCityMutableArray {
    if (!_historyCityMutableArray) {
        _historyCityMutableArray = [[NSMutableArray alloc] init];
    }
    return _historyCityMutableArray;
}

- (NSArray *)hotCityArray {
    if (!_hotCityArray) {
        _hotCityArray = @[@"北京市", @"上海市", @"广州市", @"深圳市", @"武汉市", @"天津市", @"西安市", @"南京市", @"杭州市", @"成都市", @"重庆市"];
    }
    return _hotCityArray;
}

- (NSMutableArray *)characterMutableArray {
    if (!_characterMutableArray) {
        _characterMutableArray = [NSMutableArray arrayWithObjects:@"!", @"#", @"$", nil];
    }
    return _characterMutableArray;
}

@end
