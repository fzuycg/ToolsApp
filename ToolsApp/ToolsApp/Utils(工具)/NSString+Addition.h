//
//  NSString+Addition.h
//  GeneralApp
//
//  Created by 杨春贵 on 2018/3/7.
//  Copyright © 2018年 CIB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)
- (CGFloat)heightForContent:(NSString *)content withWidth:(CGFloat)width withFont:(UIFont*)font;

- (CGFloat)widthForContent:(NSString *)content withHeight:(CGFloat)height withFont:(UIFont*)font;

- (NSInteger)linesWithContent:(NSString *)content withWidth:(CGFloat)width withFont:(UIFont *)font;

@end
