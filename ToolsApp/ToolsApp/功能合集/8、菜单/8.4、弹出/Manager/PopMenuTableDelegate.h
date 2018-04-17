//
//  PopMenuTableDelegate.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 点击cell事件回调
 */
typedef void(^TableViewDidSelectRowAtIndexPath)(NSInteger indexRow);

@interface PopMenuTableDelegate : NSObject <UITableViewDelegate>

/**
 * 对 cell 代理初始化
 */
- (instancetype) initWithDidSelectRowAtIndexPath:(TableViewDidSelectRowAtIndexPath)tableViewDidSelectRowAtIndexPath;
@end
