//
//  MoreAppCell.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoxFunctionModel;
@class MoreAppCell;

@protocol MoreAppCellDelegate <NSObject>
@optional

/**
 点击加号（减号）按钮
 */
- (void)addButtonIsClick:(MoreAppCell *)cell functionId:(NSInteger)functionId;
@end

@interface MoreAppCell : UICollectionViewCell
@property (nonatomic, weak) id<MoreAppCellDelegate> delegate;
@property (nonatomic, strong) BoxFunctionModel *model;
@property (nonatomic, assign) BOOL isEditStatus; //是否是编辑状态
@property (nonatomic, assign) BOOL isSelectStatus; //是否是选中状态（添加上去）

@end
