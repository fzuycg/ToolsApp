//
//  UIFont+YCGSize.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/11/29.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "UIFont+YCGSize.h"
#import <objc/runtime.h>

@implementation UIFont (YCGSize)

+(void)load{

    //获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    //获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    //然后交换类方法
    method_exchangeImplementations(newMethod, method);

}

//在6p上字体扩大1.5倍
//+(UIFont *)adjustFont:(CGFloat)fontSize{
//
//    UIFont *newFont = nil;
//    if (IS_IPHONE_6_PLUS){
//        newFont = [UIFont adjustFont:fontSize * 1.5];
//    }else{
//        newFont = [UIFont adjustFont:fontSize];
//    }
//    return newFont;
//}

//以6s未基准（因为一般UI设计是以6s尺寸为基准设计的）的字体。在5s和6P上会根据屏幕尺寸，字体大小会相应的扩大和缩小
+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont adjustFont:fontSize * [UIScreen mainScreen].bounds.size.width/375];
    return newFont;
}

//以6s未基准（因为一般UI设计是以6s尺寸为基准设计的）的字体。在5s和6P上会根据屏幕尺寸，字体大小会相应的扩大和缩小
//在6s上字号是17,在6P是上字号扩大到18号（字号扩大1个字号），在4s和5s上字号缩小到15号字（字号缩小2个字号）
//+(UIFont *)adjustFont:(CGFloat)fontSize{
//
//    UIFont *newFont = nil;
//    if (IS_IPHONE_5 || IS_IPHONE_4){
//        newFont = [UIFont adjustFont:fontSize - IPHONE5_INCREMENT];
//    }else if (IS_IPHONE_6_PLUS){
//        newFont = [UIFont adjustFont:fontSize + IPHONE6PLUS_INCREMENT];
//    }else{
//        newFont = [UIFont adjustFont:fontSize];
//    }
//    return newFont;
//}

@end
