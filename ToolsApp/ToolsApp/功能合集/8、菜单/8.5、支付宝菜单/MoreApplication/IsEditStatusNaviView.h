//
//  IsEditStatusNaviView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/9.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IsEditStatusNaviViewDelegate <NSObject>

- (void)cancelButtonIsClick;

- (void)completeButtonIsClick;

@end

@interface IsEditStatusNaviView : UIView
@property (nonatomic, weak) id<IsEditStatusNaviViewDelegate> delegate;

@end
