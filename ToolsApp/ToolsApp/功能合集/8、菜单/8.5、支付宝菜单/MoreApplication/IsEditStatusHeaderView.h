//
//  IsEditStatusHeaderView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoreAppCell;

@protocol IsEditStatusHeaderViewDelegate <NSObject>
@optional

/**
 点击完成按钮
 */
- (void)completeButtonIsClick;

/**
 点击减号（加号）按钮
 */
- (void)deleteButtonIsClick:(MoreAppCell *)cell functionId:(NSInteger)functionId;

@end

@interface IsEditStatusHeaderView : UIView
@property (nonatomic, weak) id<IsEditStatusHeaderViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *boxFunctionArray;
@property (nonatomic, strong) UICollectionView *collectionView;

- (void)refreshUI;

@end
