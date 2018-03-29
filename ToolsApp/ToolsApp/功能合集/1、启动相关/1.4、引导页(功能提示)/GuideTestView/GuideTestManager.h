//
//  GuideTestManager.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/29.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuideTestManager : NSObject

+ (instancetype)shareManager;

- (void)showGuideViewWithTapViews:(NSArray<UIView *>*)tapViews withTips:(NSArray<NSString *>*)tips;

@end
