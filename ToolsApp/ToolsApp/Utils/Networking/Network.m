//
//  Network.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "Network.h"

@implementation Network

/**
 *  此处模拟数据请求,实际项目中请做真实请求
 */
+(void)getLaunchAdDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LaunchAdData" ofType:@"json"]];
        NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@">>%@",json);
        if(success) success(json);
        
    });
}

@end
