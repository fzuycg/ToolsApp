//
//  NoEditStatusNaviView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/9.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoEditStatusNaviViewDelegate <NSObject>

- (void)backButtonIsClick;

@end

@interface NoEditStatusNaviView : UIView
@property (nonatomic, weak) id<NoEditStatusNaviViewDelegate> delegate;

@end
