//
//  NSString+Addition.m
//  GeneralApp
//
//  Created by 杨春贵 on 2018/3/7.
//  Copyright © 2018年 CGY. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (CGFloat)heightForContent:(NSString *)content withWidth:(CGFloat)width withFont:(UIFont*)font
{
    CGSize contentSize;
//    if (IS_IOS_7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font};
        
        contentSize = [content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    }
//
//    else{
//        contentSize = [content sizeWithFont:font
//                          constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
//                              lineBreakMode:NSLineBreakByWordWrapping];
//    }
    
    
    return contentSize.height;
}

- (CGFloat)widthForContent:(NSString *)content withHeight:(CGFloat)height withFont:(UIFont *)font{
    CGSize contentSize;
//    if (IS_IOS_7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font};
        
        contentSize = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    }
//
//    else{
//        contentSize = [content sizeWithFont:font
//                          constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
//                              lineBreakMode:NSLineBreakByWordWrapping];
//    }
    
    
    return contentSize.width;
}

- (NSInteger)linesWithContent:(NSString *)content withWidth:(CGFloat)width withFont:(UIFont *)font {
    // 获取单行时候的内容的size
    CGSize singleSize = [content sizeWithAttributes:@{NSFontAttributeName:font}];
    // 获取多行时候,文字的size
    CGSize textSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    // 返回计算的行数
    NSInteger lines = ceil( textSize.height / singleSize.height);
    return lines;
}

@end
