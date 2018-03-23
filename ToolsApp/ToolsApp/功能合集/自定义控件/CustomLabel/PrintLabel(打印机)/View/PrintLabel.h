//
//  PrintLabel.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/3/22.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PrintLabelCompleteBlock)(void);

@interface PrintLabel : UILabel

/**
 打字间隔时间，默认0.3秒
 */
@property (nonatomic, assign) NSTimeInterval time;

/**
 开始打印的位置索引，默认0
 */
@property (nonatomic, assign) int currentIndex;

/**
 打印字体颜色
 */
@property (nonatomic, retain) UIColor *printColor;

/**
 是否有打印声音，默认YES
 */
@property (nonatomic, assign) BOOL hasSound;

/**
 打印完成的回调
 */
@property (nonatomic, assign) PrintLabelCompleteBlock completeBlock;

- (void)startPrint;

@end
