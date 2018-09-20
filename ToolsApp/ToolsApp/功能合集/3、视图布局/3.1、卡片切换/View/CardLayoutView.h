//
//  CardLayoutView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CycleImageModel;

@protocol CardLayoutViewDelegate <NSObject>
@optional

- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface CardLayoutView : UIView
@property (nonatomic, weak) id<CardLayoutViewDelegate> delagate;

/**
 数据源
 */
@property (nonatomic, strong) NSArray<CycleImageModel*> *dataArray;

/**
 当前选中位置
 */
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

/**
 是否分页，默认为true
 */
@property (nonatomic, assign) BOOL pagingEnabled;

/**
 手动滚动到某个卡片位置
 */
- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated;

@end
