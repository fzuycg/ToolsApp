//
//  Define.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/16.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#ifndef Define_h
#define Define_h

//-------------------设备尺寸------------------------
//NavBar高度
#define StatusBar_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavigationBar_HEIGHT 44

#define Navigation_HEIGHT StatusBar_HEIGHT+NavigationBar_HEIGHT

#define kScreen_bounds [UIScreen mainScreen].bounds
#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width

#define kIs_iPhoneX ([UIScreen mainScreen].bounds.size.width == 375.f && [UIScreen mainScreen].bounds.size.height == 812.f ? YES : NO)

//--------------------颜色--------------------------
//格式0xdae8a6
#define JDCOLOR_FROM_RGB_OxFF_ALPHA(rgbValue,al)                    \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

//设置随机颜色
#define YCGRandomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:0.1];

#define YCGRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

//-------------------打印日志-------------------------
//DEBUG 模式下打印日志,当前行
#ifdef DEBUG

#define DeLog(format,...) printf("%s [Line %d]  \n%s\n",__PRETTY_FUNCTION__, __LINE__,[[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )

#else

# define DeLog(...)

#endif

#endif /* Define_h */
