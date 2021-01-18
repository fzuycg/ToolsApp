//
//  CGYUnicode.m
//  GeneralApp
//
//  Created by 杨春贵 on 2018/10/26.
//  Copyright © 2018 CGY. All rights reserved.
//

#import "CGYUnicode.h"

#import <objc/runtime.h>

static inline void CGY_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (CGYUnicode)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (CGYUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        CGY_swizzleSelector(class, @selector(description), @selector(CGY_description));
        CGY_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(CGY_descriptionWithLocale:));
        CGY_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(CGY_descriptionWithLocale:indent:));
    });
}

/**
 *  我觉得
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */

- (NSString *)CGY_description {
    return [[self CGY_description] stringByReplaceUnicode];
}

- (NSString *)CGY_descriptionWithLocale:(nullable id)locale {
    return [[self CGY_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)CGY_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self CGY_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (CGYUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        CGY_swizzleSelector(class, @selector(description), @selector(CGY_description));
        CGY_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(CGY_descriptionWithLocale:));
        CGY_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(CGY_descriptionWithLocale:indent:));
    });
}

- (NSString *)CGY_description {
    return [[self CGY_description] stringByReplaceUnicode];
}

- (NSString *)CGY_descriptionWithLocale:(nullable id)locale {
    return [[self CGY_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)CGY_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self CGY_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (CGYUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        CGY_swizzleSelector(class, @selector(description), @selector(CGY_description));
        CGY_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(CGY_descriptionWithLocale:));
        CGY_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(CGY_descriptionWithLocale:indent:));
    });
}

- (NSString *)CGY_description {
    return [[self CGY_description] stringByReplaceUnicode];
}

- (NSString *)CGY_descriptionWithLocale:(nullable id)locale {
    return [[self CGY_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)CGY_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self CGY_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
