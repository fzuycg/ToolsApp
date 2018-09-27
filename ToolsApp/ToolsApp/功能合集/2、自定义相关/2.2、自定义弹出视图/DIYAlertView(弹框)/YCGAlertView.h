//
//  YCGAlertView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/26.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    AlertCancelButtonClick = 0,
    AlertSureBUttonClick
} AlertButtonClickIndex;

@protocol YCGAlertViewDelegate <NSObject>

- (void)alertViewDidClickButtonWithIndex:(NSInteger)index;

@end

@interface YCGAlertView : UIView
@property (nonatomic, weak) id<YCGAlertViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancel sureButtonTitle:(NSString *)sure;

- (void)show;

@end

NS_ASSUME_NONNULL_END
