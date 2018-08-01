//
//  NoEditStatusHeaderView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/30.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoEditStatusHeaderViewDelegate <NSObject>
@optional

/**
 点击编辑按钮
 */
- (void)editButtonIsClick;

@end

@interface NoEditStatusHeaderView : UIView
@property (nonatomic, weak) id<NoEditStatusHeaderViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *boxFunctionArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
