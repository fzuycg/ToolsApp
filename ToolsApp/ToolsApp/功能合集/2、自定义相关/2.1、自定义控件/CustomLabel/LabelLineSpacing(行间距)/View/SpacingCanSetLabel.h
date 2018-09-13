//
//  SpacingCanSetLabel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpacingCanSetLabel : UILabel

- (instancetype)initWithFrame:(CGPoint)point withWidth:(CGFloat)width withContent:(NSString *)content withFont:(UIFont *)font withSpacing:(CGFloat)spacing;

@end
