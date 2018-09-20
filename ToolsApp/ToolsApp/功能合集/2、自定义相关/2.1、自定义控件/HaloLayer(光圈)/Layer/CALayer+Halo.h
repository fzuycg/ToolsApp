//
//  CALayer+Halo.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/19.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "HaloLayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Halo)
/** 光晕层 圆角 */
- (void)applyHaloLayerWithRadius:(CGFloat)radius color:(UIColor *)color;
/** 光晕层 直角 */
- (void)applyHaloLayerWithWidth:(CGFloat)width color:(UIColor *)color;
/** 移除光晕层 */
- (void)removeHaloLayer;
    
@end

NS_ASSUME_NONNULL_END
