//
//  NSString+RegexCategory.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/21.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegexCategory)


/** 判断是否是url */
- (BOOL)isValidUrl;

/** 判断是否安全(不为空) */
- (BOOL)stringIsSafe;

@end
