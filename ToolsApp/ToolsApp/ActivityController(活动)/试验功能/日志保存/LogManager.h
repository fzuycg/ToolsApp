//
//  LogManager.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/10.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogManager : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Method

/**
 *  写入日志
 *
 *  @param logStr 日志信息,动态参数
 */
- (void)saveLogStr:(NSString*)logStr, ...;

/**
 *  清空过期的日志
 */
- (void)clearExpiredLog;

/**
 *  检测日志是否需要上传
 */
- (void)checkLogNeedUpload;

@end
