//
//  PopMenuView.h
//  ToolsApp
//
//  Created by 杨春贵 on 2018/4/17.
//  Copyright © 2018年 com.yangcg.learn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMenuView : UIView

struct MenuRect {
    CGFloat pointX;     //顶点 x
    CGFloat pointY;     //顶点 y
    CGFloat menuWidth;  //菜单 w
    CGFloat menuHeight; //菜单 h
};

@property (nonatomic, copy) void(^action)(NSInteger index);
@property (nonatomic, strong) UITableView * tableView;


- (instancetype)initWithFrame:(CGRect)frame
                     menuRect:(struct MenuRect)menuRect
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action;
@end
