//
//  CALayer+Halo.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/19.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "CALayer+Halo.h"

@implementation CALayer (Halo)

/** 光晕层 */
- (void)applyHaloLayerWithRadius:(CGFloat)radius color:(UIColor *)color {
    self.cornerRadius = radius;
    
    CGSize size = self.bounds.size;
    CGPoint position = CGPointMake(size.width / 2, size.height / 2);
    size.width += radius * 2;
    size.height += radius * 2;
    [self removeHaloLayer];
    HaloLayer *halo = [HaloLayer layerWithSize:size haloColor:color radius:radius];
    halo.position = position;
    [self insertSublayer:halo atIndex:0];
}
    
- (void)applyHaloLayerWithWidth:(CGFloat)width color:(UIColor *)color {
    self.cornerRadius = 0;
    
    CGSize size = self.bounds.size;
    CGPoint position = CGPointMake(size.width / 2, size.height / 2);
    size.width += width * 2;
    size.height += width * 2;
    [self removeHaloLayer];
    HaloLayer *halo = [HaloLayer layerWithSize:size haloColor:color width:width];
    halo.position = position;
    [self insertSublayer:halo atIndex:0];
}
    
- (void)removeHaloLayer {
    NSMutableArray *array = [NSMutableArray array];
    for (CALayer *layer in self.sublayers)
    {
        if ([layer isKindOfClass:[HaloLayer class]])
        {
            [array addObject:layer];
        }
    }
    for (HaloLayer *layer in array)
    {
        [layer removeFromSuperlayer];
    }
    array = nil;
}
    
@end
