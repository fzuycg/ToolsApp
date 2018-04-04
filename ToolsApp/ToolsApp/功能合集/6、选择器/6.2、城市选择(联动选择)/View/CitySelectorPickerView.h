//
//  CitySelectorPickerView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/4.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitySelectorPickerViewDelegate <NSObject>
@optional
/**
 取消选择
 */
- (void)cancelClick;
/**
 隐藏视图（点击取消与点击空白处）
 */
- (void)viewDismiss;
/**
 完成选择

 @param province 省
 @param city 市
 @param area 区
 */
- (void)completingTheSelection:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end

@interface CitySelectorPickerView : UIView
@property (nonatomic, weak) id<CitySelectorPickerViewDelegate> delegate;
@property (nonatomic ,assign) BOOL isComplete;//是否完成选择
@property (nonatomic ,assign) BOOL isCurrentLocation;//AddressPickView是否显示输入框内地址
@property (nonatomic ,strong) NSString *currentProvince;//当前输入框内“省”
@property (nonatomic ,strong) NSString *currentCity;//当前输入框内“市”
@property (nonatomic ,strong) NSString *currentArea;//当前输入框内“区”

@property (nonatomic ,strong) UIColor *backGroundViewColor;//背景灰色阴影的色值（默认黑色）
@property (nonatomic ,assign) CGFloat backGroundViewAplha;//背景灰色阴影透明度（默认透明度0.3）

@property (nonatomic ,strong) UIColor *cancelBtnColor;//取消按钮色值 (默认#444444)
@property (nonatomic ,strong) UIColor *completeBtnColor;//完成按钮色值 (默认#444444)

@property (nonatomic ,strong) UIColor *pickerViewBackGroundColor;//弹出的addressPickerView的PickerView背景色 （默认）


- (void)show;//默认有动画
- (void)show:(BOOL)animation;

- (void)hide;//默认有动画
- (void)hide:(BOOL)animation;

@end
