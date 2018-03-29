//
//  CardLayoutView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardLayoutViewDelegate <NSObject>
@optional
- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface CardLayoutView : UIView
@property (nonatomic, weak) id<CardLayoutViewDelegate> delagate;

@property (nonatomic, strong) NSArray *dataArray;

@end
