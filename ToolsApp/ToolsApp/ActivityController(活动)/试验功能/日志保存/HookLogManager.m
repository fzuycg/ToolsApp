//
//  HookLogManager.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/8/10.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import "HookLogManager.h"
#import "fishhook/fishhook.h"
#import "LogManager.h"

@implementation HookLogManager

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)startHookLog {
    // 初始化方法里进行替换
//    rebind_symbols((struct rebinding[1]){{"NSLog", new_NSLog, (void *)&orig_NSLog}}, 1);
    //NSLog最终也是调用writev，所以不用再替换NSLog
    rebind_symbols((struct rebinding[1]){{"writev", new_writev, (void *)&orig_writev}}, 1);
    
    //删除过期日志
    [[LogManager sharedInstance] clearExpiredLog];
}

#pragma mark - Hook NSLog
// orig_NSLog是原有方法被替换后 把原来的实现方法放到另一个地址中
// new_NSLog就是替换后的方法了
static void (*orig_NSLog)(NSString *format, ...);
void(new_NSLog)(NSString *format, ...) {
    va_list args;
    if(format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        orig_NSLog(@"%@", message);
        va_end(args);
    }
}


#pragma mark - Hook writev
static ssize_t (*orig_writev)(int a, const struct iovec * v, int v_len);
ssize_t new_writev(int a, const struct iovec *v, int v_len) {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < v_len; i++) {
        char *c = (char *)v[i].iov_base;
        [string appendString:[NSString stringWithCString:c encoding:NSUTF8StringEncoding]];
    }
    ssize_t result = orig_writev(a, v, v_len);
    //日志保存本地
    [[LogManager sharedInstance] saveLogStr:string];
    return result;
}


@end
