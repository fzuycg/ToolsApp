//
//  StatusBarMessageView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusBarMessageView : UIWindow

@property (nonatomic, strong)UIColor *statusColor;
@property (nonatomic, strong)UIColor *textColor;
@property (nonatomic, assign)NSTextAlignment textAlignment;
@property (nonatomic, strong)UIFont *textFont;

- (void)showStatusWithMessage:(NSString *)text;

@end
