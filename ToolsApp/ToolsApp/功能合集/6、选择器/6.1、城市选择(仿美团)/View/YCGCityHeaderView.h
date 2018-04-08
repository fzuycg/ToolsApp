//
//  YCGCityHeaderView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCGCityHeaderViewDelegate <NSObject>

- (void)cityNameWithSelected:(BOOL)selected;
- (void)beginSearch;
- (void)endSearch;
- (void)searchText:(NSString *)text;

@end

@interface YCGCityHeaderView : UIView
@property (nonatomic, weak) id<YCGCityHeaderViewDelegate> delegate;

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *btnTitle;

- (void)cancelSearch;

@end
