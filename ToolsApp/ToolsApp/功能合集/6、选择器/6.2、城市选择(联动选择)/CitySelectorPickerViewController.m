//
//  CitySelectorPickerViewController.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/4.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CitySelectorPickerViewController.h"
#import "CitySelectorPickerView.h"

@interface CitySelectorPickerViewController () <CitySelectorPickerViewDelegate>
@property (nonatomic, weak) UIButton *selectorBtn;
@property (nonatomic, weak) UILabel *cityLabel;
@property (nonatomic, weak) CitySelectorPickerView *pickerView;

@end

@implementation CitySelectorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kNavigation_HEIGHT+60, kScreen_width, 40)];
    label.font = [UIFont systemFontOfSize:16.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blueColor];
    label.text = @"北京  北京  东城区";
    [self.view addSubview:label];
    self.cityLabel = label;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_width-120)/2, kNavigation_HEIGHT+140, 120, 46)];
    btn.layer.cornerRadius = 7;
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"选择城市" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.selectorBtn = btn;
    
    CitySelectorPickerView *view = [[CitySelectorPickerView alloc] init];
    view.delegate = self;
    [self.view addSubview:view];
    self.pickerView = view;
}

- (void)btnClick:(id)sender {
    [_pickerView show];
}

#pragma mark - CitySelectorPickerViewDelegate
- (void)cancelClick {
    [_pickerView hide];
}

- (void)completingTheSelection:(NSString *)province city:(NSString *)city area:(NSString *)area {
    _cityLabel.text = [NSString stringWithFormat:@"%@  %@  %@", province, city, area];
}

- (void)viewDismiss {
    
}

@end
