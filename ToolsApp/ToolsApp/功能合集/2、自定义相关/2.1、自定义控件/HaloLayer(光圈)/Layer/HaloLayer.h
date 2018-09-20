//
//  HaloLayer.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/19.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface HaloLayer : CALayer

// 直角
+ (HaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color width:(CGFloat)width;
+ (HaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color width:(CGFloat)width outward:(BOOL)outward;
    
// 圆角
+ (HaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color radius:(CGFloat)radius;
+ (HaloLayer *)layerWithSize:(CGSize)size haloColor:(UIColor *)color radius:(CGFloat)radius outward:(BOOL)outward ;

@end

NS_ASSUME_NONNULL_END
