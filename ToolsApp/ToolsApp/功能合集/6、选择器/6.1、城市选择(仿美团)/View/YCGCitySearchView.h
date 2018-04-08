//
//  YCGCitySearchView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/8.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCGCitySearchViewDelegate <NSObject>

- (void)searchResults:(NSDictionary *)results;
- (void)touchViewToExit;
@end

@interface YCGCitySearchView : UIView
@property (nonatomic, weak) id<YCGCitySearchViewDelegate> delegate;
/* 搜索结果 **/
@property (nonatomic, strong) NSMutableArray *resultArray;

@end
