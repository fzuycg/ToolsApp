//
//  YCGGuidePageView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/19.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCGGuidePageView : UIView

/** 选中的page指示器颜色,默认灰色 */
@property(nonatomic,retain)UIColor *currentColor;

/** 非当前页page圆点的颜色,默认白色 */
@property(nonatomic,retain)UIColor *nomalColor;

/** 是否显示小圆点 */
@property (nonatomic,assign) BOOL isShowPageView;

/** 是否滑动到最后一页结束，默认是 */
@property (nonatomic, assign) BOOL isScrollOut;

- (instancetype)initGuideViewWithImages:(NSArray *)imageArray;

@end
