//
//  BoxViewI700.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/7/26.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BoxViewI700Delegate <NSObject>
@required

- (void)itemClick:(NSInteger)itemId;

@end

@interface BoxViewI700 : UIView
@property (nonatomic, weak) id<BoxViewI700Delegate> delegate;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *boxFunctionArray;

- (void)refreshUI;

@end
