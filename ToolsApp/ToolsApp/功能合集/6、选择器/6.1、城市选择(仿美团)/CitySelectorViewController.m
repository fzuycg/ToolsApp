//
//  CitySelectorViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CitySelectorViewController.h"
#import "YCGLocationManager.h"
#import "YCGAreaDataManager.h"
#import "YCGCityViewController.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface CitySelectorViewController () <YCGCityViewControllerDelegate, YCGLocationManagerDelegate>
@property (nonatomic, strong) UILabel *cityLabel; //选择结果
@property (nonatomic, strong) YCGAreaDataManager *areaDataManager; //数据管理
@property (nonatomic, strong) YCGLocationManager *locationManager; //定位管理

@end

@implementation CitySelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    self.locationManager = [[YCGLocationManager alloc] init];
    _locationManager.delegate = self;
}

- (void)createUI {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kNavigation_HEIGHT+100, kScreen_width/2, 40)];
    label.textAlignment = NSTextAlignmentRight;
    label.text = @"当前城市：";
    [label setFont:[UIFont systemFontOfSize:16.0]];
    [self.view addSubview:label];
    
    [self.view addSubview:self.cityLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-160)/2, kNavigation_HEIGHT+160, 160, 44)];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 7;
    [btn setTitle:@"选择城市" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    YCGCityViewController *cityViewController = [[YCGCityViewController alloc] init];
    cityViewController.delegate = self;
    cityViewController.title = @"城市";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - YCGCityViewControllerDelegate
- (void)cityName:(NSString *)name {
    _cityLabel.text = name;
}

#pragma mark - YCGLocationManagerDelegate
//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    if (![_cityLabel.text isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _cityLabel.text = city;
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.areaDataManager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@...",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@...",message);
}

#pragma mark - getter
- (YCGAreaDataManager *)areaDataManager {
    if (!_areaDataManager) {
        _areaDataManager = [YCGAreaDataManager shareManager];
        [_areaDataManager areaSqliteDBData];
    }
    return _areaDataManager;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_width/2, kNavigation_HEIGHT+100, kScreen_width/2, 40)];
        _cityLabel.textAlignment = NSTextAlignmentLeft;
        _cityLabel.text = @"请选择城市";
        [_cityLabel setFont:[UIFont systemFontOfSize:16.0]];
        [_cityLabel setTextColor:[UIColor blueColor]];
    }
    return _cityLabel;
}

@end
