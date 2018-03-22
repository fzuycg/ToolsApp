//
//  Network.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/20.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkSucess) (NSDictionary * response);
typedef void(^NetworkFailure) (NSError *error);

@interface Network : NSObject

/**
 *  此处用于模拟数据请求,实际项目中请做真实请求
 */
+(void)getLaunchAdDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure;

@end
