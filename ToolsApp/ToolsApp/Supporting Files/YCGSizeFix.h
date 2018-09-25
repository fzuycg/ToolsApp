//
//  YCGSizeFix.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/9/25.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef YCGSizeFix_h
#define YCGSizeFix_h

CG_INLINE CGFloat GAFixFloatToiPhone6Width(CGFloat floatValue) {
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    CGFloat scale = CGRectGetWidth(mainFrame) /375;
    return floatValue *scale;
}


#endif /* YCGSizeFix_h */
