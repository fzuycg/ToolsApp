//
//  CycleImageView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CycleImageViewDelegate <NSObject>

@optional
- (void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface CycleImageView : UIView
@property (nonatomic, weak)id<CycleImageViewDelegate> delegate;

@property (nonatomic, strong) NSArray *dataArray;

@end
