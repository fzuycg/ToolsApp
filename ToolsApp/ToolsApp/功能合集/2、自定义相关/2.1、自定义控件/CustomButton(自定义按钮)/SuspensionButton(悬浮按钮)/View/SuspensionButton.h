//
//  SuspensionButton.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuspensionButtonDelegate <NSObject>
@optional
- (void)suspensionButtonClick;

@end

@interface SuspensionButton : UIView
@property (nonatomic, weak) id<SuspensionButtonDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setButtonEdge:(CGFloat)buttonEdge;
- (void)setButtonImage:(UIImage *)image;
- (void)setButtonTitle:(NSString *)text;
- (void)setButtonTitleColor:(UIColor *)color;
- (void)setButtonBackgroundColor:(UIColor *)color;

@end
