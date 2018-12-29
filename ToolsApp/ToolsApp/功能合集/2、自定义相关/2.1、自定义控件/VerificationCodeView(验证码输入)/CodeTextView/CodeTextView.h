//
//  CodeTextView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/10/22.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CodeTextView : UIView

@property (nonatomic, copy, readonly) NSString *code;

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

@end



#pragma mark -
#pragma mark - ----------下划线---------------
@interface LineView : UIView

@property (nonatomic, weak) UIView *colorView;

- (void)animation;

@end

NS_ASSUME_NONNULL_END
