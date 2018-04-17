//
//  PopMenuView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMenuView : UIView

@property (nonatomic, assign) CGRect menuFrame;
@property (nonatomic, copy) void(^action)(NSInteger index);
@property (nonatomic, copy) NSArray * menuItem;
@property (nonatomic, strong) UITableView * tableView;


- (instancetype)initWithFrame:(CGRect)frame
                     menuFrame:(CGRect)menuFrame
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action;
@end
