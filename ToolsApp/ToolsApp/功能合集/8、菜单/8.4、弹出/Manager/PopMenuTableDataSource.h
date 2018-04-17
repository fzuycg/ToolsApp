//
//  PopMenuTableDataSource.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PopMenuModel,PopMenuTableViewCell;

/**
 * 由model 设置cell 的回调
 */
typedef void(^TableViewCellConfigureBlock) (PopMenuTableViewCell * cell,PopMenuModel * model);

/**
 * 数据源管理类的封装
 */
@interface PopMenuTableDataSource : NSObject <UITableViewDataSource>

/**
 *  创建数据源管理
 *
 *  @param anItems             数据源
 *  @param cellClass           cell 类
 *  @param aConfigureCellBlock 设置cell的回调
 */
- (instancetype) initWithItems:(NSArray *)anItems
                     cellClass:(Class)cellClass
            configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;
@end
