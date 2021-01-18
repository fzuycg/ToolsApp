//
//  UIImage+DrawAddition.m
//  ToolsApp
//
//  Created by 杨春贵 on 2019/1/11.
//  Copyright © 2019 com.yangcg.learn. All rights reserved.
//

#import "UIImage+DrawAddition.h"

@implementation UIImage (DrawAddition)

+ (UIImage *) ly_imageWithColor:(UIColor *)color {
//    return [UIImage ly_imageWithColor:color Size:CGSizeMake(12.0f, 20.0f)];
    UIImage *arrowImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(14, 24), 0, NO);
    CGPoint startPoint = CGPointMake(12 ,2);
    CGPoint centerPoint = CGPointMake(2, 12);
    CGPoint endPoint = CGPointMake(12, 22);
    
    UIBezierPath *bezierpath = [UIBezierPath bezierPath];
    bezierpath.lineWidth = 2;
    [bezierpath moveToPoint:startPoint];
    [bezierpath addLineToPoint:centerPoint];
    [bezierpath addLineToPoint:endPoint];
    
    [color setStroke];
    [bezierpath stroke];
    
    arrowImage = UIGraphicsGetImageFromCurrentImageContext();
    return arrowImage;
}

+ (UIImage *) ly_imageWithColor:(UIColor *)color Size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image ly_stretched];
}
- (UIImage *) ly_stretched
{
    CGSize size = self.size;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(truncf(size.height-1)/2, truncf(size.width-1)/2, truncf(size.height-1)/2, truncf(size.width-1)/2);
    
    return [self resizableImageWithCapInsets:insets];
}

@end
