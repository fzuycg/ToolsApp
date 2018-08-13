//
//  SaveLogManager.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/10.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 使用重定向的方式把日志存储到本地文件中
 
 优点：
    1、直接把输出到控制台的内容存储到文件中，不用过多操作；
    2、print的输出也可以抓取；
 
 缺点：
    1、重定向到文件后，控制台就没有了输出；
    2、不能对输出字符流进行操作；
 
 */
@interface SaveLogManager : NSObject

+ (instancetype)sharedInstance;

- (void)redirectNSLogToDocumentFolder;

@end
