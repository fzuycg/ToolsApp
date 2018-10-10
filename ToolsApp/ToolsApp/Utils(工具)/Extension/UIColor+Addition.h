//
//  UIColor+Addition.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/28.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Addition)

+ (BOOL)isLightColor:(UIColor*)color;

+ (UIColor *)colorWithARGBString:(NSString *)argbString;
+ (UIColor *)colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
