//
//  UIColor+Addition.m
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/28.
//  Copyright © 2018 com.yangcg.learn. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)


// 判断颜色是不是亮色
+ (BOOL)isLightColor:(UIColor*)color {
    CGFloat components[3];
    [self getRGBComponents:components forColor:color];
    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    
    CGFloat num = components[0] + components[1] + components[2];
    if(num < 382)
        return NO;
    else
        return YES;
}

//获取RGB值
+ (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 bitmapInfo);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}

// 十六进制（有透明度）
+ (UIColor *)colorWithARGBString:(NSString *)argbString {
    if ([argbString isEqualToString:@"clear"]) {
        return [UIColor clearColor];
    }
    
    if(argbString.length < 8) {
        return [self colorWithHexString:argbString];
    }
    
    if([self judgeColorString:argbString]) {
        argbString = [argbString substringWithRange:NSMakeRange(1, 8)];
    }
    else {
        return nil;
    }
    
    NSRange alphaRange = NSMakeRange(0, 2);
    NSRange redRange = NSMakeRange(2, 2);
    NSRange greenRange = NSMakeRange(4, 2);
    NSRange blueRange = NSMakeRange(6, 2);
    
    CGFloat alpha = [self valueOfHexString:[argbString substringWithRange:alphaRange]];
    CGFloat red = [self valueOfHexString:[argbString substringWithRange:redRange]];
    CGFloat green = [self valueOfHexString:[argbString substringWithRange:greenRange]];
    CGFloat blue = [self valueOfHexString:[argbString substringWithRange:blueRange]];
    
    return [UIColor colorWithRed:red/255. green:green/255. blue:blue/255. alpha:alpha/255.];
}

// 进制转换
+ (NSUInteger)valueOfHexString:(NSString *)Hexstring {  // ff -> 255
    NSScanner *scanner = [NSScanner scannerWithString:Hexstring];
    unsigned int value = 0;
    [scanner scanHexInt:&value];
    NSUInteger retValue = value;
    return retValue;
}

// 判断字符串是否是颜色
+ (BOOL)judgeColorString:(NSString *)colorString { //@"#ffeeaa00"
    NSString *regix = @"^#[a-fA-F\\d]{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regix];
    return [predicate evaluateWithObject:colorString];
}

// 十六进制（没有透明度）
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }else if([color length] > 8){
        return [self colorWithARGBString:color];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


@end
