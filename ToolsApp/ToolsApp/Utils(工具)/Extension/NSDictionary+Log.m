//
//  NSDictionary+Log.m
//  JMColumnMenu
//
//  Created by 杨春贵 on 2018/7/25.
//  Copyright © 2018年 ljm. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

/**
 解决字典输出中文乱码的问题
 
 @return 输出结果
 */
- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *string = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [string appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [string appendString:@"}\n"];
    
    return string;
}

@end


@implementation NSArray (Log)

/**
 解决数组输出中文乱码的问题
 
 @return 输出结果
 */
- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *string = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [string appendFormat:@"\t%@,\n", obj];
    }];
    if ([string hasSuffix:@",\n"]) {
        
        [string deleteCharactersInRange:NSMakeRange(string.length - 2, 1)]; // 删除最后一个逗号
    }
    [string appendString:@")\n"];
    
    return string;
}

@end
