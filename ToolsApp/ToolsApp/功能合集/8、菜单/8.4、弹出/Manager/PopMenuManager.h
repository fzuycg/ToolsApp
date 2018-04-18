//
//  PopMenuManager.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopMenuView.h"

@interface PopMenuManager : NSObject

+ (instancetype)sharedInstance;

/**
 创建一个弹出菜单

 @param menuRect 顶点(x,y)宽高(w,h)
 @param item 内容数据
 @param action 回调点击方法
 */
- (void) showPopMenuSelecteWithFrame:(struct MenuRect)menuRect
                                item:(NSArray *)item
                              action:(void(^)(NSInteger index))action;

/**
 隐藏菜单
 */
- (void) hideMenu;
@end
