//
//  SpacingCanSetLabel.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/13.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "SpacingCanSetLabel.h"
#import "NSString+Addition.h"

@implementation SpacingCanSetLabel

- (instancetype)initWithFrame:(CGPoint)point withWidth:(CGFloat)width withContent:(NSString *)content withFont:(UIFont *)font withSpacing:(CGFloat)spacing {
    self = [super initWithFrame:CGRectMake(point.x, point.y, width, 0)];
    if (self) {
        NSInteger lines = [content linesWithContent:content withWidth:width withFont:font];
        CGFloat stringHeight = [content heightForContent:content withWidth:width withFont:font];
        
        self.frame = CGRectMake(point.x, point.y, width, stringHeight+(lines-1)*(spacing - font.lineHeight + font.pointSize));
        self.text = content;
        self.font = font;
        self.textColor = [UIColor blackColor];
        self.numberOfLines = 0;
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        //行间距，这里设置的直接是文字之间的行间距，所以减去预留位置
        paragraphStyle.lineSpacing = spacing - (font.lineHeight - font.pointSize);
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
        self.attributedText = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    }
    return self;
}

/**
 参考来源：https://juejin.im/post/5abc54edf265da23826e0dc9
 */

@end
