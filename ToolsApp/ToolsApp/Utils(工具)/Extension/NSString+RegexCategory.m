//
//  NSString+RegexCategory.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "NSString+RegexCategory.h"

@implementation NSString (RegexCategory)

- (BOOL)isValidUrl
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

- (BOOL)stringIsSafe {
    return !([self isEqual:[NSNull null]] || (self == nil) || [@"null" isEqual:self] || [@"(null)" isEqual:self] || [@"<null>" isEqual:self] || self.length == 0);
}

@end
