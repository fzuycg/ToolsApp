//
//  Define.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/16.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width

//格式0xdae8a6
#define JDCOLOR_FROM_RGB_OxFF_ALPHA(rgbValue,al)                    \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]

//设置随机颜色
#define YCGRandomColor  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:0.1];

#endif /* Define_h */
