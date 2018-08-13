//
//  HookLogManager.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/10.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 使用fishhook对输出流进行本地保存
 
 优点：
    1、可以对输出流进行操作；
    2、不影响控制台输出；
 
 缺点：
    1、print输出无法抓取（可以抓，目前没有写）；
    2、需要依靠第三方库；
 */
@interface HookLogManager : NSObject

+ (instancetype)sharedInstance;

- (void)startHookLog;

@end
