//
//  YCGLocationManager.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/4.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YCGLocationManagerDelegate <NSObject>

/**
 定位中
 */
- (void)locating;

/**
 当前位置

 @param dictionary 位置信息
 */
- (void)currentLocation:(NSDictionary *)dictionary;

/**
 拒绝定位
 
 @param message 提示信息
 */
- (void)refuseToUsePositioningSystem:(NSString *)message;

/**
 定位失败
 
 @param message 提示信息
 */
- (void)locateFailure:(NSString *)message;

@end

@interface YCGLocationManager : NSObject
@property (nonatomic, weak) id<YCGLocationManagerDelegate> delegate;

@end
