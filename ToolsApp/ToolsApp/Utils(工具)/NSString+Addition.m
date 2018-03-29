//
//  NSString+Addition.m
//  GeneralApp
//
//  Created by 杨春贵 on 2018/3/7.
//  Copyright © 2018年 CIB. All rights reserved.
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
@end
